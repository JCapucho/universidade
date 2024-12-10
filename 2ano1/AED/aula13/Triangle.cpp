#include "Triangle.h"

#include <cassert>
#include <cmath>
#include <iostream>
#include <string>

#include "Point.h"
#include "Triangle.h"

Triangle::Triangle(void) : Figure(), sideA_(1), sideB_(1), angle_(M_PI / 3) {}

Triangle::Triangle(Point center, const std::string &color, double sideA,
                   double sideB, double angle)
    : Figure(center, color), sideA_(sideA), sideB_(sideB), angle_(angle) {
  assert(sideA > 0.0);
  assert(sideB > 0.0);
  assert(angle > 0.0);
}

Triangle::Triangle(double x, double y, const std::string &color, double sideA,
                   double sideB, double angle)
    : Triangle(Point(x, y), color, sideA, sideB, angle){};

double Triangle::GetSideA(void) const { return sideA_; }
void Triangle::SetSideA(double sideA) {
  assert(sideA > 0.0);
  sideA_ = sideA;
}
double Triangle::GetSideB(void) const { return sideB_; }
void Triangle::SetSideB(double sideB) {
  assert(sideB > 0.0);
  sideB_ = sideB;
}
double Triangle::GetAngle(void) const { return angle_; }
void Triangle::SetAngle(double angle) {
  assert(angle > 0.0);
  angle_ = angle;
}

double Triangle::GetSideC(void) const {
  double sideA2 = sideA_ * sideA_;
  double sideB2 = sideB_ * sideB_;
  return std::sqrt(sideA2 + sideB2 - 2 * sideA_ * sideB_ * std::cos(angle_));
}
