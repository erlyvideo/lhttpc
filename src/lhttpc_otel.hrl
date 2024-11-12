-ifdef(otel_telelemetry).

-define(OTEL_START(),
  otel:start_span(#{kind => client, name => <<"HTTP client">>})).

-define(OTEL_SETATTRS(Attrs),
  otel:setattrs(Attrs)).

-define(OTEL_HEADERS(),
  case otel:traceparent() of
    undefined -> [];
    TraceParent -> [{<<"traceparent">>,TraceParent}]
  end).

-define(OTEL_OPTIONS(),
 [{otel,otel:get_context()}]).

-define(OTEL_END(Status),
  otel:end_span(Status)).

-define(OTEL_CONTEXT(Options),
  otel:set_context(proplists:get_value(otel, Options))).

-else.

-define(OTEL_START(), ok).

-define(OTEL_SETATTRS(Attrs), begin _ = Attrs, ok end).

-define(OTEL_HEADERS(), []).

-define(OTEL_OPTIONS(), []).

-define(OTEL_END(Status), begin _ = Status, ok end).

-define(OTEL_CONTEXT(Options), begin _ = Options, ok end).

-endif.
