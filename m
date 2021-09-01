Content-Type: multipart/mixed; boundary="===============0018759549586130876=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Cannot connect to SAE protected AP with iwd 1.16 and beyond
Date: Wed, 01 Sep 2021 10:51:33 -0500
Message-ID: <5d96c118-78ed-c483-055a-3c7e4a4018fa@gmail.com>
In-Reply-To: <20210901130952.2717.97994@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0018759549586130876==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jesus,

On 9/1/21 8:09 AM, Jesus Gonzalez wrote:
> Hello Denis,
> =

> the breaking commit is not in iwd, but ell. This one:
> =

> https://git.kernel.org/pub/scm/libs/ell/ell.git/commit/?id=3D05f4de966395=
0bcd4519ebec8d8c0998dc889936

*Jedi voice* This is not the commit you're looking for.

Seriously, yes I figured that.  This commit is the one that changes the beh=
avior =

of which key size we choose by default when negotiating SAE.  I already =

indicated this in my very first reply on the subject :)

What we need is a log as to why the group negotiation part of the SAE hands=
hake =

fails on your AP.  You are running a fairly recent hostapd version which =

_should_ support SAE group re-negotiation correctly.  In fact, we are runni=
ng =

almost the same setup as you without any problems.

Logs from hostapd and iwd, as well as an iwmon capture would be a starting =
point =

for us to look into this.

Regards,
-Denis
--===============0018759549586130876==--

