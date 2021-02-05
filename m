Content-Type: multipart/mixed; boundary="===============6450856282407732183=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH 2/2] auto-t: update roaming tests with
 wait_for_object_change
Date: Fri, 05 Feb 2021 15:58:49 -0800
Message-ID: <2d54257601894474240ade44a0483264f30a5595.camel@gmail.com>
In-Reply-To: <CAOq732Je57sQrXz-frVXuLrZFT6EvyzDWgVjYA4N5k+RYyW=iw@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6450856282407732183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Sat, 2021-02-06 at 00:50 +0100, Andrew Zaborowski wrote:
> Hi James,
> =

> On Fri, 5 Feb 2021 at 20:06, James Prestwood <prestwoj@gmail.com>
> wrote:
> > Every single roaming test had one of two problems with watching the
> > state change between roaming --> connected. Either the test used
> > wait_for_object_condition to wait for 'connected' which could allow
> > other states in between. Or it simply used an assert. The assert
> > wouldn't allow other state changes, but at the cost of potentially
> > failing due to IWD not having made it to the 'connected' state yet.
> =

> Can you give an example of a sequence of states?  I can't see a
> scenario where there would be a difference between the state before
> ce5e1e1933dbb11c503702ca0ee7a3d0f142ff4b and after this patch.

Commit ce5e1e1 was a mistake, although some FT tests already did this.
As the comments state in most FT tests we want to make sure IWD doesnt
fully disconnect e.g. because roaming failed. Using
wait_for_object_condition allows any state in between so we don't want
that, and a simple assert may not allow enough time for IWD to fully
roam. Hence this API which waits for state without allowing
intermediate states.

Not sure of any example besides roaming->disconnected->connected.

Thanks,
James
> =

> Best regards

--===============6450856282407732183==--

