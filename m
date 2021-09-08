Content-Type: multipart/mixed; boundary="===============4907036603877629949=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: Cannot connect to SAE protected AP with iwd 1.16 and beyond
Date: Wed, 08 Sep 2021 09:44:38 -0700
Message-ID: <f5cfcfa7eba43d3b4718ef1dabad50a4bbe16b19.camel@gmail.com>
In-Reply-To: <20210908084142.2717.20785@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4907036603877629949==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jesus,

On Wed, 2021-09-08 at 08:41 +0000, Jesus Gonzalez wrote:
> Hello James,
> =

> it seems to be working, thank you! I'll keep an eye on it for the
> next day or so and report any error, but it was fairly obvious when
> it failed before in the same scenarios I just tested, so I don't
> expect it to fail again.
> =

> From my non-expert point of view it is weird that changing 1
> encryption algorithm parameter (the curve, or its key size?) changes
> the behavior of the authentication/association sequence.

I went into a bit more detail with Paul, but in your case I think the
status code 77 was a red herring. The actual reason your AP was denying
authentication was due to, what the AP thought was, an extra commit
message being sent which it treated as a fatal error. So by removing
this commit message in IWD we prevent that hostapd code path from being
taken in the first place.

Thanks,
James



--===============4907036603877629949==--

