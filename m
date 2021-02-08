Content-Type: multipart/mixed; boundary="===============5335374392840233878=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 2/2] auto-t: update roaming tests with
 wait_for_object_change
Date: Mon, 08 Feb 2021 14:16:23 +0100
Message-ID: <CAOq732KAxX9GfhVN8j0bVB1PTyeCxrpB8mfaCcsvvFQn3ZyoMQ@mail.gmail.com>
In-Reply-To: <2d54257601894474240ade44a0483264f30a5595.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5335374392840233878==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 6 Feb 2021 at 00:59, James Prestwood <prestwoj@gmail.com> wrote:
> On Sat, 2021-02-06 at 00:50 +0100, Andrew Zaborowski wrote:
> > Hi James,
> >
> > On Fri, 5 Feb 2021 at 20:06, James Prestwood <prestwoj@gmail.com>
> > wrote:
> > > Every single roaming test had one of two problems with watching the
> > > state change between roaming --> connected. Either the test used
> > > wait_for_object_condition to wait for 'connected' which could allow
> > > other states in between. Or it simply used an assert. The assert
> > > wouldn't allow other state changes, but at the cost of potentially
> > > failing due to IWD not having made it to the 'connected' state yet.
> >
> > Can you give an example of a sequence of states?  I can't see a
> > scenario where there would be a difference between the state before
> > ce5e1e1933dbb11c503702ca0ee7a3d0f142ff4b and after this patch.
>
> Commit ce5e1e1 was a mistake, although some FT tests already did this.
> As the comments state in most FT tests we want to make sure IWD doesnt
> fully disconnect e.g. because roaming failed. Using
> wait_for_object_condition allows any state in between so we don't want
> that, and a simple assert may not allow enough time for IWD to fully
> roam.

Can this really happen, since the assert follows a
wd.wait_for_object_condition(device, 'obj.state !=3D
DeviceState.roaming')?

Best regards
--===============5335374392840233878==--

