Content-Type: multipart/mixed; boundary="===============3112086765652087987=="
MIME-Version: 1.0
From: Mauro Condarelli <mc5686@mclink.it>
Subject: Re: iwctl force autoconnect
Date: Mon, 29 Mar 2021 19:09:01 +0200
Message-ID: <f5fa26ae-90b5-2e88-1931-512dac405f11@mclink.it>
In-Reply-To: <beb7757f-f62c-7d87-da89-a71a65e572b7@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3112086765652087987==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 3/29/21 6:37 PM, Denis Kenzior wrote:
> Hi Mauro,
>
> On 3/29/21 11:29 AM, Mauro Condarelli wrote:
>>> So in theory this should always be happening.=C2=A0 Once iwd is in
>>> 'autoconnect' state (starting state, or when we lose a connection)
>>> then any scan results triggered (either internal scanning logic or
>>> scans triggered via dbus/iwctl) should then be considered for
>>> autoconnect purposes.=C2=A0 You say that 'it's not always the case'. So
>>> this works for you sometimes and not other times?=C2=A0 Can you capture
>>> some logs for us?=C2=A0 Also, are you running any other network manager=
s on
>>> top of iwd or just iwd standalone?
>>
>> I am guessing he needs to re-enter 'autoconnect' state after an explicit
>> disconnect.
>>
>
> 'explicit disconnect' as in 'station wlan0 disconnect'?=C2=A0 That should=
 really never be necessary, and in fact it has the side-effect of disabling=
 autoconnect. =C2=A0We probably should have never enabled this command in i=
wctl.
>
>> Use case for this would be to disconnect from the currently connected
>> net and try to connect to some other, if available.
>>
>> What would be command sequence for this?
>
> So while connected, it should just be 'station wlan0 connect <some other =
network>'.=C2=A0 iwd will gracefully switch networks=C2=A0 (disconnect from=
 old + connect to new) for you.
That is not exactly what I asked.
This is for use case "I want to connect to a specific network".

I asked for the "negated": "please connect to *any* net=C2=A0 *but* the cur=
rent one".

There are also cases where you want to temporarily disconnect and later rec=
onnect to the same or other net, without necessarily having preferences.

This would be particularly useful for "unattended servers" where there's no=
body to actually chose.

I think a "enter autoconnect state" command could be useful, at the very le=
ast for testing/fallback.

>
> Regards,
> -Denis
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org
>
Regards
Mauro

--===============3112086765652087987==--

