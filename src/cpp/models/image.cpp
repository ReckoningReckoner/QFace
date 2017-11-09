#include <string>
#include <vector>
#include "Image.h"
#include "MatModel.h"
#include "base64.h"

using namespace std;
using namespace cv;

// Constructor given cv::Mat
Image::Image(cv::Mat matrix) : imageData(matrix){
}

// Constructor given base64 string
Image::Image(std::string base64EncodedImage){
	std::vector<unsigned char> imageBytes = base64_decode(base64EncodedImage); // Decodes the given base64 string to a vector of unsigned chars
	cv::Mat data_mat(imageBytes,true); // Create an opencv matrix object from the vector of unsigned chars
	imageData = data_mat;
}

// Constructor given byte vector
Image::Image(std::vector<unsigned char> imageBytes){
	cv::Mat data_mat(imageBytes,true); // opencv constructor for a matrix
	imageData = data_mat; // Set imageData to the matrix created above
}

// Returns the image as a matrix
cv::Mat Image::asMat() const{
	return imageData;
}

// Returns the image as a base 64 string
std::string Image::asBase64(){
	std::vector<unsigned char> imageBytes; // Vector variable declaration
  	convertMatToByteVector(imageData,&imageBytes); // Converts the imageData matrix to a vector and stores it into imageBytes
  	std::string encodedData = base64_encode(&imageBytes[0], imageBytes.size()); // Encodes the vector to a base64 string
  	return encodedData; // Return the encoded string
}

// Returns the image as a vector of unsifned chars (bytes)
std::vector<unsigned char> Image::asBytes(){
	std::vector<unsigned char> imageBytes; // Vector variable declaration
	convertMatToByteVector(imageData,&imageBytes); // Converts the imageData matrix to a vector and stores it into imageBytes
	return imageBytes; // Return the vector
}

