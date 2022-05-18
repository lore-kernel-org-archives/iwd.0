Content-Type: multipart/mixed; boundary="===============9103193463281795417=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459 at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v3 1/2] netconfig: Add multiple levels to IWD_DHCP_DEBUG
Date: Wed, 18 May 2022 16:17:54 +0100
Message-ID: <CACsRnHUgcoAM2kNQg0oe1bfjnRvhncHazs7CKecVHYuESWBPLQ@mail.gmail.com>
In-Reply-To: 0886D7EE-6F64-4B79-A752-980FEA0752B4@holtmann.org

--===============9103193463281795417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Wed, 18 May 2022 at 15:48, Marcel Holtmann <marcel(a)holtmann.org> wrote:

> > +     l_dhcp_client_set_debug(netconfig->dhcp_client, do_debug,
> > +                                     "[DHCPv4] ", NULL, dhcp_priority);
>
> please don=E2=80=99t always set l_dhcp_client_set_debug. It should not be=
 set. And I don=E2=80=99t like the dhcp_priority parameter at all. That is =
just convoluted code and there is no precedence with any _set_debug() APIs.

Just so I'm on the same page, my intention is to turn on logging with
the DHCP client by default so warnings and errors aren't silently
dropped. Ideally I would also like to have a certain level of info
logging that matches other DHCP clients so it's possible to see what
state the system is in. Maybe this isn't something iwd is interested
in, which is fine, but if it is, what would you propose I do instead
here?

Regards,
Michael
--===============9103193463281795417==--

