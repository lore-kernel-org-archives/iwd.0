Content-Type: multipart/mixed; boundary="===============0934828891079478081=="
MIME-Version: 1.0
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Subject: Re: [RFC connman 1/1] WIP: Add WPA3-SAE support
Date: Wed, 26 May 2021 18:21:37 -0300
Message-ID: <1a66150d-6d5d-f4af-3207-d0510b9be695@collabora.com>
In-Reply-To: <20210526070534.vtewwjiftzfxwki3@beryllium.lan>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0934828891079478081==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On 5/26/21 4:05 AM, Daniel Wagner wrote:
> Hi Ariel,
> =

> On Tue, May 25, 2021 at 06:53:44PM -0300, Ariel D'Alessandro wrote:
>> On 5/19/21 4:32 AM, Daniel Wagner wrote:
[snip]
> There is no need to expose implementation details to the user API. SAE
> belongs to the family of PSK, hence if the user selects PSK via the
> Service API, the implementation should choose the right protocol. Since
> wpa_supplicant does not do this on it's own the plugin has to do this.
> =

> If you compare this to the iwd setup, the plugins/iwd.c does not even
> know that SAE is used, it doesn't care. iwd does the right thing.
> =

> Basically this means, if SAE is available just use it, there is no need
> to bother the user.

Got it, thanks for the explanation.

So, correct me if I'm wrong:

* Changes to src/service.c should be dropped. No need to add
CONNMAN_SERVICE_SECURITY_SAE as we'll be treating WPA3-SAE as
CONNMAN_SERVICE_SECURITY_PSK.

* A WPA3-SAE service can be named as *_psk. No need to name it as *_sae.

Looking at Tizen's implementation:

* In order to check if SAE is available, key_mgmt capabilities should be
stored in GSupplicantSSID as done in [0]. This way d-bus field key_mgmt
can be set accordingly, similar to what's done in [1].

Note that Tizen is also storing this inside struct connman_network [2].
Let me know if this is allowed or should be addressed in a different way.

Thanks a lot,
Ariel

[0]
https://review.tizen.org/git/?p=3Dplatform/upstream/connman.git;a=3Dblob;f=
=3Dgsupplicant/gsupplicant.h;h=3D05af5de128544b1c1e36e7cfce5ae024c217d6ee;h=
b=3DHEAD#l228

[1]
https://review.tizen.org/git/?p=3Dplatform/upstream/connman.git;a=3Dblob;f=
=3Dgsupplicant/supplicant.c;h=3Dc727c074373d67ddc238634bd4399be204e2aed4;hb=
=3DHEAD#l7199

[2]
https://review.tizen.org/git/?p=3Dplatform/upstream/connman.git;a=3Dblob;f=
=3Dsrc/network.c;h=3D870749f0182911a4e7221e0fd531fd654398bf7d;hb=3DHEAD#l122
--===============0934828891079478081==--

