Content-Type: multipart/mixed; boundary="===============5958275001897677215=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] station: only add diagnostic interface when connected
Date: Wed, 03 Feb 2021 13:38:35 -0600
Message-ID: <9f92939a-d73a-b751-4889-a66362f314d0@gmail.com>
In-Reply-To: <20210203190705.184958-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5958275001897677215==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/3/21 1:07 PM, James Prestwood wrote:
> The diagnostic interface returns an error anyways if station is
> not connected so it makes more sense to only bring the interface
> up when its actually usable. This also removes the interface
> when station disconnects, which was never done before (the
> interface stayed up indefinitely due to a forgotten remove call).
> ---
>   src/station.c | 23 ++++++++++++-----------
>   1 file changed, 12 insertions(+), 11 deletions(-)
> =


Both applied, thanks.

Regards,
-Denis

--===============5958275001897677215==--

