`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2024 14:50:12
// Design Name: 
// Module Name: image_preprocessor
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module ImagePreprocessor (
  input wire clk,
  input wire reset,
  input wire [7:0] image_data_in,
  output reg [7:0] preprocessed_image
);

  parameter IMG_WIDTH = 512;  // Define image width
  parameter IMG_HEIGHT = 512; // Define image height

  reg [7:0] filtered_image[0:IMG_HEIGHT-1][0:IMG_WIDTH-1]; // Temporary storage for filtered image

  // Implement a simple averaging filter for noise reduction
  always @(posedge clk) begin
    if (reset) begin
      for (int i = 0; i < IMG_HEIGHT; i++) begin
        for (int j = 0; j < IMG_WIDTH; j++) begin
          filtered_image[i][j] <= 0;
        end
      end
    end else begin
      integer sum = 0;
      for (int i = -1; i <= 1; i++) begin
        for (int j = -1; j <= 1; j++) begin
          if ((i + j) == 0) begin
            sum += image_data_in;
          end
        end
      end
      filtered_image <= sum >> 2; // Divide by number of neighbors (9) for averaging
    end
  end

  // Implement basic contrast enhancement (histogram equalization can be explored)
  always @(posedge clk) begin
    if (reset) begin
      preprocessed_image <= 0;
    end else begin
      integer histogram[256];
      integer max_count = 0;

      // Calculate image histogram
      for (int i = 0; i < IMG_HEIGHT; i++) begin
        for (int j = 0; j < IMG_WIDTH; j++) begin
          histogram[filtered_image[i][j]]++;
          if (histogram[filtered_image[i][j]] > max_count) begin
            max_count = histogram[filtered_image[i][j]];
          end
        end
      end

      // Apply histogram equalization (simplified version)
      integer new_intensity;
      for (int i = 0; i < IMG_HEIGHT; i++) begin
        for (int j = 0; j < IMG_WIDTH; j++) begin
          new_intensity = 0;
          for (int k = 0; k <= filtered_image[i][j]; k++) begin
            new_intensity += histogram[k];
          end
          new_intensity = (new_intensity * 255) / max_count;
          preprocessed_image[i][j] <= new_intensity;
        end
      end
    end
  end
endmodule

module FeatureExtractor (
  input wire clk,
  input wire reset,
  input wire [7:0] preprocessed_image,
  output reg [7:0] features
);

  parameter IMG_WIDTH = 512;  // Define image width
  parameter IMG_HEIGHT = 512; // Define image height

  // Calculate standard deviation within a small image block (3x3)
  reg [15:0] sum, sq_sum;

  always @(posedge clk) begin
    if (reset) begin
      features <= 0;
      sum <= 0;
      sq_sum <= 0;
    end else begin
      integer block_size = 3;
      integer image_data_in_x = 0; // Placeholder for X-coordinate of input image
      integer image_data_in_y = 0; // Placeholder for Y-coordinate of input image

      for (int i = 0; i < block_size; i++) begin
        for (int j = 0; j < block_size; j++) begin
          if ((image_data_in_x + i >= 0) && (image_data_in_x + i < IMG_WIDTH) &&
              (image_data_in_y + j >= 0) && (image_data_in_y + j < IMG_HEIGHT)) begin
            sum += preprocessed_image[image_data_in_y + j][image_data_in_x + i];
            sq_sum += preprocessed_image[image_data_in_y + j][image_data_in_x + i] * preprocessed_image[image_data_in_y + j][image_data_in_x + i];
          end
        end
      end
      
      integer num_pixels = block_size * block_size;
      integer mean = sum / num_pixels;
      integer variance = (sq_sum / num_pixels) - (mean * mean);
      features <= sqrt(variance); // Calculate square root to get standard deviation
    end
  end
endmodule
