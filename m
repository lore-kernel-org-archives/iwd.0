Content-Type: multipart/mixed; boundary="===============7519440507537356773=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 3/5] eapol: Remove assumption of single cipher in
 authenticator IE
Date: Sat, 30 Jan 2021 12:35:40 +0100
Message-ID: <CAOq732KXGgtpss3PRBpg6LkZr2d1yw_0KWprevB8RyCF_HMa4g@mail.gmail.com>
In-Reply-To: <25c34b3b-edf3-49de-8ed2-071ed03c878f@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7519440507537356773==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Sat, 30 Jan 2021 at 03:28, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Andrew,
>
> On 1/29/21 5:27 PM, Andrew Zaborowski wrote:
> > Allow the user of the eapol_sm & handshake_state APIs to have multiple
> > pairwise ciphers listed in the authenticator IE.  This comes at the cost
> > of requiring the user to call handshake_state_override_pairwise_cipher
> > to select the cipher when setting up the handshake state.
>
> That's unfortunate.  Why would we want to override pairwise_ciphers selec=
ted by
> the STA?  I mean we can maybe do this for testing, but in the general cas=
e?
> Furthermore, why would the override API be _required_?
>
> What precludes us from advertising an RSNE with multiple pairwise ciphers=
 and
> then honoring the single pairwise_cipher that the STA chose?

It was the assumption that the client STA can set more than one cipher
but I think that was wrong.  We didn't validate this because the
authenticator RSNE had only one cipher set so it was enough to bitwise
& them.  I'll add the check and simplify the code.

Best regards
--===============7519440507537356773==--

