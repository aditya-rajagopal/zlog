const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const zlog = b.addModule("zlog", .{
        .root_source_file = b.path("src/zlog.zig"),
        .target = target,
        .optimize = optimize,
    });

    const benchmark = b.addExecutable(.{
        .name = "benchmark",
        .root_source_file = b.path("src/benchmark.zig"),
        .target = target,
        .optimize = optimize,
    });
    benchmark.root_module.addImport("zlog", zlog);

    b.installArtifact(benchmark);

    const run_benchmark = b.addRunArtifact(benchmark);
    const run_step = b.step("run", "Run the log benchmark");
    run_step.dependOn(&run_benchmark.step);

    const exe_check = b.addExecutable(.{
        .name = "testbed",
        .root_source_file = b.path("src/benchmark.zig"),
        .target = target,
        .optimize = optimize,
    });
    exe_check.root_module.addImport("zlog", zlog);

    const check_step = b.step("check", "Check if the app compiles");
    check_step.dependOn(&exe_check.step);
}
