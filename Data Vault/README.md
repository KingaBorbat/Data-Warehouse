# Package Execution Order

This document outlines the order in which the packages need to be run based on their dependencies.

Run the packages in the following order:

1. **HUB** packages - no dependencies
2. **LINK** packages - depend on **HUB** packages
3. **SAT** packages - depend on **HUB** and some **LINK** packages
