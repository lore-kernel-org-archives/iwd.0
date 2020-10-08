Content-Type: multipart/mixed; boundary="===============1898522533560452419=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/5] network: Stop autoconnect during agent request or ANQP
Date: Thu, 08 Oct 2020 10:25:36 -0500
Message-ID: <18d3efc4-2440-f63a-ea7f-9292769c2d76@gmail.com>
In-Reply-To: <20201008084911.1046485-5-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1898522533560452419==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 10/8/20 3:49 AM, Andrew Zaborowski wrote:
> Stop autoconnect whenever we're saving a pending DBus message and resume
> when we return the error response.

So I don't think that we can do it this way.  The problem is that multiple =

Network.Connects may exist in the 'Obtain secrets' stage.  So even if you p=
ause =

autoconnect for the first, the 2 .. n would still end up  pending in the =

autoconnect stage...

We probably need to discuss the whys of what you're trying to accomplish he=
re...

Regards,
-Denis
--===============1898522533560452419==--

