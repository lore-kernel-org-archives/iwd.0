Content-Type: multipart/mixed; boundary="===============3796531210111383472=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 2/7] ip-pool: Add subnet address selection logic
Date: Wed, 26 May 2021 23:50:25 +0200
Message-ID: <CAOq732K-PWxCyxecBN54dEdiRALdnZEZTZpWgD9C6CKRocc65Q@mail.gmail.com>
In-Reply-To: <c119acaf-d675-fca9-62a4-87fcefca4000@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3796531210111383472==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 26 May 2021 at 21:56, Denis Kenzior <denkenz@gmail.com> wrote:
> On 5/25/21 7:55 AM, Andrew Zaborowski wrote:
> > +int ip_pool_select_addr4(const char **addr_str_list, uint8_t prefix,
> > +                             struct netdev *netdev, uint32_t *out_addr=
);
> >   const struct ip_pool_addr4_record *ip_pool_get_addr4(struct netdev *n=
etdev);
> >
>
> Similarly to previous patch, do we really need the netdev object here?
>
> Also, what is 'prefix'?  It looks like it is used to convey the desired p=
refix
> length size.  So should it be named appropriately?  Maybe target_prefix_l=
en?

Yep, I'll fix this.

>
> Do you really need the netdev argument? It looks like it is used to skip =
adding
> that netdev's addresses to the 'used' list.  Why?  How likely is this to =
happen?
>   Can't we just leave those alone and assign a new subnet regardless?

Sure, we can drop this functionality.  It sounded like a correct thing
to do but if there's a problem with it I can drop it.  Note we'll save
exactly 3 non-empty-non-comment lines of code.

> Or have AP
> wipe the addresses first?

Now that would be trading an integer comparison (the ifindex check..)
for a multi-step asynchronous operation with cancellation, error
checks, etc., I wouldn't do this to save that one argument.

Best regards
--===============3796531210111383472==--

