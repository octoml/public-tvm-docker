## TVM Compiler
A docker image with recent dependencies, and a HEAD build of TVM

## How to use
If you are trying to kickoff an automated build using docker hub, edit the `TVM_HASH` build arg in the `octoml` docker hub build page. Otherwise you can edit `TVM_HASH` in `Justfile` and build and push manually (or use locally).


## Future work
* Right now this is not comprehensive (doesn't include everything in TVM) since it's geared for production use cases, though it's somewhat of a middle ground.
* Add another layer with Jupyter notebook tools
* Pare this down into a more bare bones build
* Add a "full TVM" variant with the kitchen sink