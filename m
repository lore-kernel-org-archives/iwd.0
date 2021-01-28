Content-Type: multipart/mixed; boundary="===============2923815922648733881=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: Re: [PATCH 2/5] auto-t: throw exception if hostapd can't send BSS
 transition req
Date: Thu, 28 Jan 2021 09:28:29 +0000
Message-ID: <41bbf3dc-9986-8418-b93c-e7955dacdca4@bang-olufsen.dk>
In-Reply-To: <facf98c54e76d319681eb842441368dd48bc7475.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2923815922648733881==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/27/21 6:28 PM, James Prestwood wrote:
> Hi Alvin,
> =

> On Wed, 2021-01-27 at 10:05 +0000, Alvin =C5=A0ipraga wrote:
>> The testAPRoam autotest was silently failing on my machine until I
>> realized that my distribution hostapd (Arch Linux) is not built with
>> CONFIG_WNM_AP=3Dy. Indeed, it is also disabled by default in upstream
>> hostapd. This resulted in the send_bss_transition() function of
>> hostapd.py silently failing. With this change, throw an exception in
>> case the BSS_TM_REQ command does not succeed to hopefully save others
>> the time of debugging this problem.
>> ---
>>   autotests/util/hostapd.py | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
>> index 019d23ba..8e0b3766 100644
>> --- a/autotests/util/hostapd.py
>> +++ b/autotests/util/hostapd.py
>> @@ -184,7 +184,10 @@ class HostapdCLI:
>>                           (addr, bss_info, op_class, chan_num,
>> phy_num)]
>>               pref +=3D 1
>>   =

>> -        ctx.start_process(cmd, wait=3DTrue)
>> +        proc =3D ctx.start_process(cmd, wait=3DTrue)
> =

> Good catch on this. Within the last day I fixed a logging/verbose issue
> with test-runner which this patch would be affected by. My
> fix/workaround is to explicitly tell start_process if there is output
> being requested with 'need_out=3DTrue'. I've got other ideas in the
> works, but for now this is how its got to be done. This should work for
> you:
> =

> proc =3D ctx.start_process(cmd, wait=3DTrue, need_out=3DTrue)

Thanks. I actually fixed the same issue of --log not working with =

hostapd_cli, but your solution was more generic so I dropped the patch =

when sending. Forgot to modify this accordingly though. Sent a v2 patch now.

Kind regards,
Alvin
--===============2923815922648733881==--

