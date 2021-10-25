Content-Type: multipart/mixed; boundary="===============0678999301650966721=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [RFC PATCH V2] ap: Expose connected stations property
Date: Mon, 25 Oct 2021 14:10:01 -0500
Message-ID: <785e38b3-d733-9384-3235-85a2c9e58957@gmail.com>
In-Reply-To: CAOf5uwnLSk9BaCJjEhj9=h8f3awNKOutvDvoPcGkErbDKeKKsw@mail.gmail.com

--===============0678999301650966721==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On 10/25/21 1:59 PM, Michael Nazzareno Trimarchi wrote:
> Hi
> =

> On Mon, Oct 25, 2021 at 8:45 PM Denis Kenzior <denkenz(a)gmail.com> wrote:
>>
>> Hi Michael,
>>
>> On 10/24/21 4:15 AM, Michael Trimarchi wrote:
>>> Add a way to be notified about the connected stations in access
>>> point mode. This can be used in order to ask from Diagnostic
>>> interface the properties for each station or to just use them
>>> from other services like connman or network manager to report
>>> the number of clients
>>
>> So do you want the actual number of clients or a way to know when the cl=
ient
>> list has changed?  If it is the latter, then a signal might be better.
>>
>> Also, you should document the new property in doc/access-point-api.txt i=
n a
>> separate patch.
> =

> I'm thinking even about:
> =

> StaAuthorized ( s : mac )
> =

> A new station has been authorized to the interface.
> =

> Arguments
> =

> s : mac A mac address which has been authorized.
> =

> StaDeauthorized ( s : mac )
> =

> A station has been deauthorized to the interface.
> =

> Arguments
> =

> s : mac A mac address which has been deauthorized.
> =

> This will be then compatible on what we have in wpa_supplicant.
> =

> I will address all your comments. Do you like more this approach?

I like this more than the original proposal.  Do note that we like to spell=
 out =

terms in our D-Bus APIs since they're more user-visible.  So maybe
	StationJoined/StationLeft
	StationConnected/StationDisconnected or
	ClientAdded/ClientRemoved

However, do note that signals are somewhat limiting.  If there's more =

information on a client that might be required in the future (obtained DHCP =

address maybe?), then modeling the client station as an object may be more =

future-proof.  With ObjectManager, above signals would be replaced by =

InterfacesAdded/InterfacesRemoved() and you would get the contents of the e=
ntire =

(future-extensible) property set instead of just the mac.

This doesn't have to be solved now since the AccessPoint API is marked =

experimental and is subject to change.  But the less churn there is, the le=
ss =

work there would be in the future to migrate from old APIs to the new.

Regards,
-Denis
--===============0678999301650966721==--

