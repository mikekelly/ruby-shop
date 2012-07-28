A Pricing Mechanism in Ruby
===========================
Goal: produce something with an API that works like this:

```
co = Checkout.new(pricing_rules)
co.scan(item)
co.scan(another_item)
co.total
```

Running The Tests
-----------------
`rake test`
