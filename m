Content-Type: multipart/mixed; boundary="===============8912114188065335755=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5] resolve: Exit methods if resolve is NULL
Date: Tue, 22 Sep 2020 09:34:39 -0500
Message-ID: <237c1ec9-7f85-59b4-19db-d4f1f36a731d@gmail.com>
In-Reply-To: <CAOq732LEKzjdC7gDhn13n9rVQ5m9KksjHwonafV1HAVeESmKWw@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8912114188065335755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 9/22/20 9:28 AM, Andrew Zaborowski wrote:
> Hi Denis,
> =

> On Tue, 22 Sep 2020 at 16:19, Denis Kenzior <denkenz@gmail.com> wrote:
>> On 9/21/20 11:18 PM, Andrew Zaborowski wrote:
>>> I'm still using netconfig from P2P, I guess we shouldn't require
>>> General.EnableNetworkConfiguration to be set for P2P.  P2P doesn't
>>> (usually) have DNS so this should still work but maybe the checks
>>> should be in netconfig.c after all, not sure.
>>
>> I don't think it makes sense to have this asymmetry.  Why is P2P special
>> compared to normal station client?
> =

> We also don't have any configuration for P2P netconfig because the
> spec mandates the use of DHCP.  There's also no legacy to worry about,
> so I don't see the point of making DHCP optional for P2P.

That isn't exactly the point I was trying to make.  P2P would always use DH=
CP or =

network config KDEs, no disagreement there.  But from a user / system =

configuration perspective I don't think this asymmetry is something that on=
e =

would expect or would want.

So if the user has not enabled EnableNetworkConfiguration setting then =

systemd-networkd (for example) expects to perform DHCP for all WiFi interfa=
ces. =

How would you tell systemd-networkd not to configure P2P devices?  They're =
just =

WiFi as far as it is concerned.

Regards,
-Denis
--===============8912114188065335755==--

