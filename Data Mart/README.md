# Package Execution Order

This document outlines the order in which the packages need to be run based on their dependencies.

Run the packages in the following order:

1. **DIMCategory, DIMCustomer, DIMFabric, DIMLocation, DIMStore, DIMDate** - no dependencies
2. **DIMSubcategory** - depends on package **DIMCatgory** package
3. **DIMProduct** - depends on package **DIMSubcategory** package
4. **BridgeFabricProduct** - depends on **DIMProduct** and **DIMFabric** packages
5. **FactSales** - depends on all the packages above except **DIMFabric** and **BridgeFabricProduct** packages
