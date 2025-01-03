Mass rollup for a Bill of Materials is an example of a class of computations in which elements are arranged in a tree structure and some property of each element is a computed function of the corresponding values of its child elements. Leaf elements, i.e., those with no children, have values assigned. In many cases, the combining function is simply the arithmetic sum; in other cases (e.g., higher-order mass properties), the combiner may involve other information such as the geometric relationship between parent and child, or statistical relations such as root-sum-of-squares (RSS). This R package implements a general framework for such problems. It is adapted to specific recursive analyses by functional programming techniques; the caller passes _get()_, _set()_, _combine()_, and (optional) _override()_ methods at runtime to specify the desired operations.