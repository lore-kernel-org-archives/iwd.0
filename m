Content-Type: multipart/mixed; boundary="===============4852553832325591183=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH 6/6] station: disable roaming logic for auto-roaming cards
Date: Thu, 11 Mar 2021 10:45:17 -0800
Message-ID: <c8ac9d4edfef6c77734249c0c9e919fb33547c87.camel@gmail.com>
In-Reply-To: <CAG17S_NLxwqtJzLy8GmK+4EfqFuuC3Hktw3QLqBCqHW4oRsY5w@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4852553832325591183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Keith,

On Thu, 2021-03-11 at 12:18 -0600, KeithG wrote:
> James,
> =

> This is confusing to me as well. Since cypress took it over, they
> have
> gone and renamed the driver cyfmac instead of brcmfmac. That is in
> what is form cypress on their web pages:
> https://community.cypress.com/gfawx74859/attachments/gfawx74859/resourcel=
ibrary/1030/1/cypress-fmac-v5.4.18-2020_0925.zip
> I was able to patch the kernel from this package and build it and it
> builds the cyfmac* drivers. THese require the cyfmac firmware... IN
> addiiton to building this patched kernel, I was also able to rename
> them and make the firmware work with the (older) official brcmfmac
> drivers. all in all confusing.

Well in any event thanks for this link. The most recent FW I could find
was Nov. 2020, and all the firmware files were 'brcmfmac-*' named. I
will give these a try, maybe SAE offload is actually enabled.

Thanks,
James

--===============4852553832325591183==--

