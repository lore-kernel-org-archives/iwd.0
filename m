Content-Type: multipart/mixed; boundary="===============5627606235369372602=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Issue with iwd 1.3 + systemd-resolved + iwd's built-in network
 configuration not adding DNS servers
Date: Tue, 17 Dec 2019 11:05:19 -0600
Message-ID: <c63dbc66-c813-0818-b3e8-beafed327276@gmail.com>
In-Reply-To: <20191217050741.2770.4721@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5627606235369372602==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caleb,

On 12/16/19 11:07 PM, caljorden(a)hotmail.com wrote:
> Hi Denis,
> =

> Thanks for sending that patch out.  I can confirm that this fixes the pro=
blem when applied to the pristine 1.3 code.

Thanks for testing!  I've pushed out this fix upstream as 295e42f87a8f =

("resolve: Don't try to set routing domains")

> =

> Is this critical enough to release a 1.4 update, or perhaps a 1.3.1?

Indeed.  We're investigating a different issue (with PEAP + MSCHAPv2) =

reported against 1.3.  Once we have that resolved we will try to get a =

1.4 out very soon.

Regards,
-Denis

Regards,
-Denis
--===============5627606235369372602==--

