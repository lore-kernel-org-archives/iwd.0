Content-Type: multipart/mixed; boundary="===============2085951505723110836=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 1/2] p2p: Add p2p.Peer.Address D-bus property
Date: Wed, 06 Oct 2021 16:00:50 -0500
Message-ID: <cd9e7cff-d84d-91b3-9140-f197aadbbfc6@gmail.com>
In-Reply-To: 20211006205214.227476-1-andrew.zaborowski@intel.com

--===============2085951505723110836==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 10/6/21 3:52 PM, Andrew Zaborowski wrote:
> Expose the Device Address property for each peer.  The spec doesn't say
> much about how permanent the address or the name are, although the
> device address by definition lives longer than the interface addresses.
> However the device address is defined to be unique and the name is not
> so the address can be used to differentiate devices with identical name.
> Being unique also may imply that it's assigned globally and thus
> permanent.
> =

> Network Manager uses the P2P device address when saving connection
> profiles (and will need it from the backend) and in this case it seems
> better justified than using the name.
> =

> The address is already in the object path but the object path also
> includes the local phy index which may change for no reason even when
> the peer's address hasn't changed so the path is not useful for
> remembering which device we've connected to before.  Looking at only
> parts of the path is considered wrong.
> ---
>   src/p2p.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> =


Both applied, thanks.

Regards,
-Denis

--===============2085951505723110836==--

