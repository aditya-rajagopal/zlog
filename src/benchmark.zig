const std = @import("std");

const zlog = @import("zlog");

pub fn main() void {
    std.debug.print("Hello, world!: {d}\n", .{zlog.test_func()});
}
