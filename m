Content-Type: multipart/mixed; boundary="===============5716070166282795176=="
MIME-Version: 1.0
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Subject: Re: [RFC connman 1/1] WIP: Add WPA3-SAE support
Date: Thu, 27 May 2021 17:28:25 -0300
Message-ID: <32b4cd1c-51d1-cde9-2577-02db72a74c26@collabora.com>
In-Reply-To: <20210527065613.ijyzdwptuvhxltl7@beryllium.lan>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5716070166282795176==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Daniel,

On 5/27/21 3:56 AM, Daniel Wagner wrote:
> Hi Ariel,
> =

> On Wed, May 26, 2021 at 06:21:37PM -0300, Ariel D'Alessandro wrote:
[...]>> Looking at Tizen's implementation:
>>
>> * In order to check if SAE is available, key_mgmt capabilities should be
>> stored in GSupplicantSSID as done in [0]. This way d-bus field key_mgmt
>> can be set accordingly, similar to what's done in [1].
> =

> Yes, that looks about right.
> =

>> Note that Tizen is also storing this inside struct connman_network [2].
>> Let me know if this is allowed or should be addressed in a different way.
> =

> I think key_mgmt could go into 'struct wifi_data'. No need to store this
> information a layer higher up.

The issue with 'struct wifi_data' is that it's attached to the device
instead of each network connection, see [0]. So, we can't store the
'key_mgmt' property there as it's a shared object.

For example, iwd plugin has two different private data structs:
iwd_device [1] and iwd_network [2].

We could have something similar in plugin/wifi.c. I'll send another RFC
patchset v2, so we can review it in-place.

Thanks,
Ariel

[0]
https://git.kernel.org/pub/scm/network/connman/connman.git/tree/plugins/wif=
i.c#n795
[1]
https://git.kernel.org/pub/scm/network/connman/connman.git/tree/plugins/iwd=
.c#n75
[2]
https://git.kernel.org/pub/scm/network/connman/connman.git/tree/plugins/iwd=
.c#n87
--===============5716070166282795176==--

