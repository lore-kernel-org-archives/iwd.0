Content-Type: multipart/mixed; boundary="===============1181146365194831137=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [RFC connman 1/1] WIP: Add WPA3-SAE support
Date: Fri, 28 May 2021 07:20:50 +0200
Message-ID: <20210528052050.l77aayrwalokkfoe@beryllium.lan>
In-Reply-To: <32b4cd1c-51d1-cde9-2577-02db72a74c26@collabora.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1181146365194831137==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 27, 2021 at 05:28:25PM -0300, Ariel D'Alessandro wrote:
> > I think key_mgmt could go into 'struct wifi_data'. No need to store this
> > information a layer higher up.
>
> The issue with 'struct wifi_data' is that it's attached to the device
> instead of each network connection, see [0]. So, we can't store the
> 'key_mgmt' property there as it's a shared object.
> =

> For example, iwd plugin has two different private data structs:
> iwd_device [1] and iwd_network [2].
> =

> We could have something similar in plugin/wifi.c. I'll send another RFC
> patchset v2, so we can review it in-place.

Yes, attach the key_mgmt to the network object via

  connman_network_{set|get}_data()

Thanks,
Daniel
--===============1181146365194831137==--

