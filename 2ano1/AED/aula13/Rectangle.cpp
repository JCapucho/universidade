//
// Algoritmos e Estruturas de Dados - 2023/2024
//
// COMPLETE the code, according to Rectangle.h
//

#include "Rectangle.h"

#include <cassert>
#include <iostream>
#include <string>

#include "Figure.h"
#include "Point.h"

Rectangle::Rectangle(void) : Figure(), height_(1), width_(1) {
  // Rectangle of width=1 and height=1 and centered at (0,0)
}

Rectangle::Rectangle(Point center, const std::string &color, double width,
                     double height)
    : Figure(center, color), height_(height), width_(width) {
  // Ensure that the width and height are larger than 0.0
  assert(width_ > 0.0);
  assert(height_ > 0.0);
}

Rectangle::Rectangle(double x, double y, const std::string &color, double width,
                     double height)
    : Figure(x, y, color), height_(height), width_(width) {
  // Ensure that the width and height are larger than 0.0
  assert(width_ > 0.0);
  assert(height_ > 0.0);
}

double Rectangle::GetHeight(void) const { return height_; }
void Rectangle::SetHeight(double length) {
  // Ensure that the height is larger than 0.0
  assert(length > 0.0);
  height_ = length;
}

double Rectangle::GetWidth(void) const { return width_; }
void Rectangle::SetWidth(double length) {
  // Ensure that the width is larger than 0.0
  assert(length > 0.0);
  width_ = length;
}

std::string Rectangle::GetClassName(void) const { return "Rectangle"; }

double Rectangle::Area(void) const { return width_ * height_; }

double Rectangle::Perimeter(void) const { return 2 * width_ + 2 * height_; }

std::ostream &operator<<(std::ostream &os, const Rectangle &obj) {
  os << "Center: " << obj.GetCenter() << std::endl;
  os << "Color: " << obj.GetColor() << std::endl;
  os << "Width = " << obj.width_ << std::endl;
  os << "Height = " << obj.height_ << std::endl;
  return os;
}

std::istream &operator>>(std::istream &is, Rectangle &obj) {
  Point center;
  is >> center;
  obj.SetCenter(center);

  std::cout << "color = ";
  std::string color;
  is.ignore();
  std::getline(is, color);
  obj.SetColor(color);

  std::cout << "width = ";
  is >> obj.width_;
  std::cout << "height = ";
  is >> obj.height_;

  return is;
}
