Content-Type: multipart/mixed; boundary="===============6665975174485275739=="
MIME-Version: 1.0
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Subject: Re: [RFC connman v1 1/1] gsupplicant: Add support for WPA3-Personal
Date: Thu, 05 Aug 2021 08:15:27 -0300
Message-ID: <d4e6e9ee-0f0b-1fa2-c814-4eebaac304ce@collabora.com>
In-Reply-To: <20210805060704.maeaww6q75x4obqy@beryllium.lan>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6665975174485275739==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On 8/5/21 3:07 AM, Daniel Wagner wrote:
> Hi Ariel,
> =

> On Wed, Aug 04, 2021 at 06:23:14PM -0300, Ariel D'Alessandro wrote:
>> Hi all, Daniel:
>>
>> WPA3 support has been recently added to connman (wpa_supplicant). As
>> we've been discussing on a previous thread, this only supports
>> WPA3-Personal-only mode.
>>
>> This RFC patchset adds support for WPA3-Personal transition mode, which
>> supports both WPA2-Personal (PSK) and WPA3-Personal (SAE).
>>
>> Based on the AP accepted key management protocols, connman configures
>> wpa_supplicant as follows:
>>
>> * WPA3-Personal-only mode: key_mgmt=3D"SAE" ; ieee80211w=3D2
>> * WPA3-Personal transition mode: key_mgmt=3D"SAE WPA-PSK" ; ieee80211w=
=3D1
>>
>> This patch applies cleanly on top of current master branch (commit
>> e36a38d8).
>>
>> I'd like to hear any thoughts you might have about this.
>> For reference, see wpa_supplicant configuration [0].
> =

> This looks good. If no one speaks up I am going to apply it.

Sounds good.

> =

> Daniel
> =

> ps: we have a new mailing list (connman(a)lists.linux.dev). The old one
> was shutdown.

Thanks for pointing that out!

Ariel
--===============6665975174485275739==--

