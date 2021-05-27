Content-Type: multipart/mixed; boundary="===============4899904041336092544=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [RFC connman 1/1] WIP: Add WPA3-SAE support
Date: Thu, 27 May 2021 08:56:13 +0200
Message-ID: <20210527065613.ijyzdwptuvhxltl7@beryllium.lan>
In-Reply-To: <1a66150d-6d5d-f4af-3207-d0510b9be695@collabora.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4899904041336092544==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ariel,

On Wed, May 26, 2021 at 06:21:37PM -0300, Ariel D'Alessandro wrote:
> So, correct me if I'm wrong:
> =

> * Changes to src/service.c should be dropped. No need to add
> CONNMAN_SERVICE_SECURITY_SAE as we'll be treating WPA3-SAE as
> CONNMAN_SERVICE_SECURITY_PSK.

Yes

> * A WPA3-SAE service can be named as *_psk. No need to name it as
> *_sae.

Yes

> Looking at Tizen's implementation:
> =

> * In order to check if SAE is available, key_mgmt capabilities should be
> stored in GSupplicantSSID as done in [0]. This way d-bus field key_mgmt
> can be set accordingly, similar to what's done in [1].

Yes, that looks about right.

> Note that Tizen is also storing this inside struct connman_network [2].
> Let me know if this is allowed or should be addressed in a different way.

I think key_mgmt could go into 'struct wifi_data'. No need to store this
information a layer higher up.

Thanks,
Daniel
--===============4899904041336092544==--

