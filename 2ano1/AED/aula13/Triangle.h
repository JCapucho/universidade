#ifndef TRIANGLE_H_
#define TRIANGLE_H_

#include <iostream>
#include <string>

#include "Figure.h"
#include "Point.h"

class Triangle : public Figure {
public:
  Triangle(void);
  Triangle(Point center, const std::string &color, double sideA, double sideB,
           double angle);
  Triangle(double x, double y, const std::string &color, double sideA,
           double sideB, double angle);

  double GetSideA(void) const;
  void SetSideA(double sideA);
  double GetSideB(void) const;
  void SetSideB(double sideB);
  double GetAngle(void) const;
  void SetAngle(double sideC);

  double GetSideC(void) const;

  std::string GetClassName(void) const;
  double Area(void) const;
  double Perimeter(void) const;

  friend std::ostream &operator<<(std::ostream &os, const Triangle &obj);
  friend std::istream &operator>>(std::istream &is, Triangle &obj);

private:
  double sideA_;
  double sideB_;
  double angle_;
};

#endif // TRIANGLE_H_
