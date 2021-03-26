const servers = {
  "ovpn-vpn1": "http://127.0.0.1:8881",
  "ovpn-vpn2": "http://127.0.0.1:8882",
};

const rules = {
  domains: {
    direct: [
      "localhost"
    ],
    proxy: [
      {
        "host": "host1.example.com",
        "proxy": "ovpn-vpn1"
      },
      {
        "host": "host2.example.com",
        "proxy": "ovpn-vpn2"
      }
    ]
  }
};

function FindProxyForURL(url, host) {
  for (let i in rules.domains.direct) {
    const r = rules.domains.direct[i];
    if (dnsDomainIs(host, r) || shExpMatch(host, r)) {
      return "DIRECT";
    }
  };

  for (let i in rules.domains.proxy) {
    const r = rules.domains.proxy[i];
    if (dnsDomainIs(host, r.host) || shExpMatch(host, r.host)) {
      return "PROXY " + servers[r.proxy];
    }
  };

  return "DIRECT";
}