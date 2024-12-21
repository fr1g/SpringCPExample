package su.kami.demo.Shared;

import su.kami.demo.Services.Service;

import java.util.HashMap;
import java.util.Map;

public class DynamicShared {
    // @Singleton

    public Map<String, Service<?>> services;

    public DynamicShared() {
        services = new HashMap<>();
    }
}
