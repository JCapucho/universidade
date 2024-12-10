//
// Algoritmos e Estruturas de Dados - 2023/2024
//
// COMPLETE the code, according to Square.h
//

#include "Square.h"

#include <cassert>
#include <iostream>
#include <string>

#include "Point.h"
#include "Rectangle.h"

Square::Square(void) : Rectangle() {
  // Rectangle of edge=1 and centered at (0,0)
}

Square::Square(Point center, const std::string &color, double length)
    : Rectangle(center, color, length, length) {}

Square::Square(double x, double y, const std::string &color, double length)
    : Rectangle(x, y, color, length, length) {}

double Square::GetEdgeLength(void) const { return GetWidth(); }
void Square::SetEdgeLength(double length) {
  SetWidth(length);
  SetHeight(length);
}

std::string Square::GetClassName(void) const { return "Rectangle"; }

std::ostream &operator<<(std::ostream &os, const Square &obj) {
  os << "Center: " << obj.GetCenter() << std::endl;
  os << "Color: " << obj.GetColor() << std::endl;
  os << "Edge length = " << obj.GetWidth() << std::endl;
  return os;
}

std::istream &operator>>(std::istream &is, Square &obj) {
  Point center;
  is >> center;
  obj.SetCenter(center);

  std::cout << "color = ";
  std::string color;
  is.ignore();
  std::getline(is, color);
  obj.SetColor(color);

  double length;
  std::cout << "edge length = ";
  is >> length;
  obj.SetEdgeLength(length);

  return is;
}
