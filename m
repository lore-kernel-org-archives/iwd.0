Content-Type: multipart/mixed; boundary="===============2738007665533871883=="
MIME-Version: 1.0
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Subject: Re: [RFC connman 1/1] WIP: Add WPA3-SAE support
Date: Fri, 28 May 2021 10:28:06 -0300
Message-ID: <a1bf1223-ac87-0225-6f5a-70521e8b2725@collabora.com>
In-Reply-To: <20210528052050.l77aayrwalokkfoe@beryllium.lan>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2738007665533871883==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On 5/28/21 2:20 AM, Daniel Wagner wrote:
> Hi,
> =

> On Thu, May 27, 2021 at 05:28:25PM -0300, Ariel D'Alessandro wrote:
>>> I think key_mgmt could go into 'struct wifi_data'. No need to store this
>>> information a layer higher up.
>>
>> The issue with 'struct wifi_data' is that it's attached to the device
>> instead of each network connection, see [0]. So, we can't store the
>> 'key_mgmt' property there as it's a shared object.
>>
>> For example, iwd plugin has two different private data structs:
>> iwd_device [1] and iwd_network [2].
>>
>> We could have something similar in plugin/wifi.c. I'll send another RFC
>> patchset v2, so we can review it in-place.
> =

> Yes, attach the key_mgmt to the network object via
> =

>   connman_network_{set|get}_data()

Indeed, that's what I submitted yesterday in RFC patchset v2.
See
https://lists.01.org/hyperkitty/list/iwd(a)lists.01.org/thread/CQRZSD3TXLIL=
EDRGPNOGW4DIFPOAGLMK/
--===============2738007665533871883==--

