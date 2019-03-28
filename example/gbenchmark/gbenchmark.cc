#include <iostream>
#include <sstream>
#include <stdio.h>
#include <string.h>

#include <benchmark/benchmark.h>

BENCHMARK_MAIN()

constexpr size_t max_range{10000000};
#define BENCH_COMPLX(x) BENCHMARK(x)->RangeMultiplier(10)->Range(10, max_range)->Complexity(benchmark::oN)

static void measure_thing(benchmark::State& state) {
  std::string s1(state.range(0), '-');
  std::string s2(state.range(0), '-');
  for (auto _ : state) {
    benchmark::DoNotOptimize(s1.compare(s2));
  }
  state.SetComplexityN(state.range(0));
}

BENCH_COMPLX(measure_thing);
