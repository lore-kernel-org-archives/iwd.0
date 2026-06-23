Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7783D75D1
	for <iwd@lists.linux.dev>; Tue, 23 Jun 2026 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782227070; cv=pass; b=kGhCcmgtQCdBBSvppdWK0z0FLboBff/xCU8GVg6p7OWo5StUHRuXzUhyW/Uocj0aVKNUvMSoDRYfJSSoSuoklkbFCe9PfDon9xP9OueGDOuSMroS5XD3ssFoyWX9bwo1Qc81epdFf1wnRP2IzebD0Zr58WDiutlT/j9F3XnQQn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782227070; c=relaxed/simple;
	bh=moeCOdPL37pA4Cm3YLyMgOX7Ltv+HpIq0MYYOWohN7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gT7vvERn6HtpalvzkBIUlQ/E9ntyXhylFps94lcAXNE6eM28Fby/yyMJZW/+PDWVtFy4mOQ83XhmWUiXiOV73e+VTpeMwVcSs0rXLXMXn1drKMa4bxoMlU8lFa62/mrq4hQNFiu0m/QyrNdF0mpu4P9A7dG3+w3U2ruUf5f2oFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h363/0B1; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h363/0B1"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c6bb8a5980so38863155ad.2
        for <iwd@lists.linux.dev>; Tue, 23 Jun 2026 08:04:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782227068; cv=none;
        d=google.com; s=arc-20240605;
        b=AbDE4DeKJ6KGyb1mZWMyG/9QuDob6Z39nwrmyDfVY20D958VLTalwBL7O8/ie9IBdB
         1ahbNrG2Km3uZ4DnMfYL6qEHxW21H0V3rZGyuNI3badjSyIiRYB30OJoDUAaed+3G6MP
         BT3ntVC6/h8hnOUOQf5zO36ji7wXlCMTnkrn6glom7Y57G+sJIvx1JONjymQILzfFDot
         zksVHOggDQzrkcHFMjByjedJtCnAWtCCYQ65lER3M7WOtyCpJenu8SVtxCHW4CjFjwPV
         3mvJWwjjxPfA8fKRfB2HLtyruydKO4ijT5q2aoZv5QA7/vPB0QvnlTRGI/kYne/lmfKv
         vJwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IJElps7NxqPdAEp+fqfuwfl85ZtuPfQzjPdU/8ZfgH4=;
        fh=bHLB47tSzlA2NlF1++64bp8pvalWLEhOmR7dJKDFDCI=;
        b=JNGLaZxwgjz2Yi5tKbdBchSJLD1j5DNBqZh7P8myxuIWa9iBXrf0HQXHq+M/RqNnnj
         1JWPHKiZEBYcSaa4oqdHoOyf4Mjg/SJwaX/2gQV+l5YU7rEu3Rq9qAZtDQ6V0lV7C9xR
         64AjSanxR/in0TUGPMl+8t8eOwXJnizWbtA914FtdQ8FHvlKzTgwkPk5UrQxJfCmjlmj
         ZNRTvvPvS6On8CxgSkWsOSaDxVuyugSvwVhXBE0QvI53t9uaolJjnFiWYN6I1nfdA45I
         hfIKIS+hrp917kavNU8Dw3rNwVg8bcTPKONrYXOqptqeSKsQIK/FfQ3NIke8Ctu7X/r3
         KRhA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782227068; x=1782831868; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJElps7NxqPdAEp+fqfuwfl85ZtuPfQzjPdU/8ZfgH4=;
        b=h363/0B1soo/866Fiu+nL69VdDqu/1DZXfXIoI44V84qckF13+9GAMvoKLqezb3kqd
         mSaF8jzQL3SlpCdbAdtc9cVHwx0JC7qVHrwfleQ5F7QwZGBexsjGcWV/bZTHkM1+hbcN
         +R5VJJxZUy/nOIoVsw085E6OaviB7aXdwEdTe732MFQ/aqc9ONrd63/n4Wm2ZnhoU51w
         WWPSbmtLJ+eVKrkE6gpJ6Wk6rAa+wjV2E2azLMDtkJvp7Tt4stCzCR3dAp1gERP7PWXZ
         5kVQdfgij9YGGZk9B4IqkN9QoBYGZQJdxBE22srImvC2yc95N2u/8O1mpsbGEC4fCM/9
         72SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782227068; x=1782831868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IJElps7NxqPdAEp+fqfuwfl85ZtuPfQzjPdU/8ZfgH4=;
        b=GBA8aaCyT0ehEfcmSX6VC/jUY9BQAyibdj7abcZJpKmUfmxl++nprMoKmXL4SFMMAx
         VhiLRN4fwfQGHCAH/G0a1GQqbqRI11uJO1KldjisqvF5Ixr6YlT2D3yOgTEh6Bw63uwv
         uCCmlgYAJEYrI2Q7oxYtkShGg8kh//3fc1eV8au2rq1c6Jpbxwpw5yU6ZNl1mgTjwNg0
         xYRMu1ZP+HXOPyyB7nMTUFfgYpSuLexn6dBE9u8PXkEDKEs613Ylt5KJ4bP0nEqXt/+Y
         2pv2u6CnCmrxGOpFbYWArlQaMtNpIX8WYrJ/VHCPsf+Oop7xogH2gq/YUjPrKeX3hia2
         8wXA==
X-Forwarded-Encrypted: i=1; AHgh+RrM0gVRBP9tgGd7diYYqvGbrBy6P2/hIjowQ7xNHPGDWzGAuKLpauYzpK2yEL/YJY5PRrs=@lists.linux.dev
X-Gm-Message-State: AOJu0YwOO4gswJ4ZRs50lt0+1iz0F3XVYvT3ACM7yC4wRhJCSyfpip7b
	wZE+fafr900CQ7pLblDe+WW2HoXth5tbvsDmuvlJxAD5Ba7x+xSA/rHhzAHfjQ4PbWiIh+AXh00
	KclUrzO0PnhnynEUV9NLi++d3fftqLp0=
X-Gm-Gg: AfdE7cl/I4iRl6lWt3SsmskTTf7kcZ45qr5PIDbXLah8+xvR+/WHsSIWGM90X8xCLcu
	UlnCK8AswLwhY7ZZMVnrty8ly60x/kuJgGmJlqPnz6TxgrMjVnquMHIKAJ2AS8+I1Aoe67lwtbC
	I8b2QMG6oEm28HqMIGnUo1sEMAk28uFT2vXBQXFtDR/22qXq+BT/FevFNtG2dynzN8e3cohL/gK
	J4Pk+KuqU3z/z2Dn4JW8+K7N1q6yaWPMh+yWhUgqexkrsDf1dPuQAXzuuOfw5cgwGN1oeT+yEdU
	wpOwhWrntiPo2DWSLtjJaNxSGht7zV3ozc5dCvEtJJt/j4LfRMDnunJS8No=
X-Received: by 2002:a17:903:2281:b0:2c2:7e17:39f6 with SMTP id
 d9443c01a7336-2c7c9a9c706mr29568135ad.36.1782227067798; Tue, 23 Jun 2026
 08:04:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260622234803.6982-1-ebiggers@kernel.org>
In-Reply-To: <20260622234803.6982-1-ebiggers@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 23 Jun 2026 11:04:14 -0400
X-Gm-Features: AVVi8Cfvovxh_AcIOv0_5Ttgx9HUcmTHdvbTOTdPXaEunw3IPLjFGMbE1c6ysnE
Message-ID: <CABBYNZ+QLvkYkn_EcBZ4+GopyhKqJLcfCoABYcw1VamavbSvhg@mail.gmail.com>
Subject: Re: [PATCH] crypto: af_alg - Add af_alg_restrict sysctl, defaulting
 to 1
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, iwd@lists.linux.dev, 
	linux-hardening@vger.kernel.org, Milan Broz <gmazyland@gmail.com>, 
	Demi Marie Obenour <demiobenour@gmail.com>, Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Mon, Jun 22, 2026 at 7:50=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> AF_ALG is a frequent source of vulnerabilities and a maintenance
> nightmare.  It exposes far more functionality to userspace than ever
> should have been exposed, especially to unprivileged processes.  Recent
> exploits have targeted kernel internal implementation details like
> "authencesn" that have zero use case for userspace access.
>
> Fortunately, AF_ALG is rarely used in practice, as userspace crypto
> libraries exist.  And when it is used, only some functionality is known
> to be used, and many users are known to hold capabilities already.
> iwd for example requires CAP_NET_ADMIN and has a known algorithm list
> (https://lore.kernel.org/linux-crypto/bcbbef00-5881-421b-8892-7be6c04b832=
d@gmail.com/).
>
> Thus, let's restrict the set of allowed algorithms by default, depending
> on the capabilities held.
>
> Add a sysctl /proc/sys/crypto/af_alg_restrict with meaning:
>
>     0: unrestricted
>     1: limited functionality
>     2: completely disabled
>
> Set the default value to 1, which enables an algorithm allowlist for
> unprivileged processes and a slightly longer allowlist for privileged
> processes.
>
> Note that the list may be tweaked in the future.  However, the common
> use cases such as iwd and bluez are taken into account already.  I've
> tested that iwd still works with the default value of 1.
>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  Documentation/admin-guide/sysctl/crypto.rst | 36 +++++++++++
>  Documentation/crypto/userspace-if.rst       | 13 +++-
>  crypto/af_alg.c                             | 72 +++++++++++++++++++--
>  crypto/algif_aead.c                         | 11 ++++
>  crypto/algif_hash.c                         | 24 +++++++
>  crypto/algif_rng.c                          |  9 +++
>  crypto/algif_skcipher.c                     | 20 ++++++
>  include/crypto/if_alg.h                     |  8 +++
>  8 files changed, 184 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/admin-guide/sysctl/crypto.rst b/Documentation/=
admin-guide/sysctl/crypto.rst
> index b707bd314a64..9a1bd53287f4 100644
> --- a/Documentation/admin-guide/sysctl/crypto.rst
> +++ b/Documentation/admin-guide/sysctl/crypto.rst
> @@ -5,10 +5,46 @@
>  These files show up in ``/proc/sys/crypto/``, depending on the
>  kernel configuration:
>
>  .. contents:: :local:
>
> +.. _af_alg_restrict:
> +
> +af_alg_restrict
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Controls the level of restriction of AF_ALG.
> +
> +AF_ALG is a deprecated and rarely-used userspace interface that is a
> +frequent source of vulnerabilities. It also unnecessarily exposes a
> +large number of kernel implementation details. For more information
> +about AF_ALG, see :ref:`Documentation/crypto/userspace-if.rst
> +<crypto_userspace_interface>`.
> +
> +Starting in Linux v7.3, AF_ALG supports only a limited set of
> +algorithms by default. This sysctl allows the system administrator to
> +remove this restriction when needed for compatibility reasons, or to
> +go further and disable AF_ALG entirely. The default value is 1.
> +
> +=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +0    AF_ALG is unrestricted.
> +
> +1    AF_ALG is supported with a limited list of algorithms. The list
> +     is designed for compatibility with known users such as iwd and
> +     bluez that haven't yet been fixed to use userspace crypto code.

Is the expectation that we go shopping for userspace crypto here? This
would mean the Bluetooth stack would use 2 different crypto stacks:
the kernel for module parts and a userspace library for components
like bluetoothd, resulting in 2 different sources to audit. So, while
I agree we should restrict it to just the algorithms in use and with
capabilities, I don't think we should assume the current userspace
users are broken and need fixing.

> +     Specifically, there is an allowlist for unprivileged processes
> +     and a somewhat longer allowlist for processes that hold
> +     CAP_SYS_ADMIN or CAP_NET_ADMIN in the initial user namespace.
> +
> +     Attempts to bind() an AF_ALG socket with a disallowed algorithm
> +     fail with ENOENT.
> +
> +2    AF_ALG is completely disabled. Attempts to create an AF_ALG
> +     socket fail with EAFNOSUPPORT.
> +=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
>  fips_enabled
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  Read-only flag that indicates whether FIPS mode is enabled.
>
> diff --git a/Documentation/crypto/userspace-if.rst b/Documentation/crypto=
/userspace-if.rst
> index ab93300c8e04..d6194346e366 100644
> --- a/Documentation/crypto/userspace-if.rst
> +++ b/Documentation/crypto/userspace-if.rst
> @@ -1,5 +1,7 @@
> +.. _crypto_userspace_interface:
> +
>  User Space Interface
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  Introduction
>  ------------
> @@ -10,13 +12,18 @@ code.
>
>  AF_ALG is insecure and is deprecated. Originally added to the kernel in =
2010,
>  most kernel developers now consider it to be a mistake. Support for hard=
ware
>  accelerators, which was the original purpose of AF_ALG, has been removed=
.
>
> -AF_ALG continues to be supported only for backwards compatibility. On sy=
stems
> -where no programs using AF_ALG remain, the support for it should be disa=
bled by
> -disabling ``CONFIG_CRYPTO_USER_API_*``.
> +AF_ALG continues to be supported only for backwards compatibility.
> +
> +Starting in Linux v7.3, the set of algorithms supported by AF_ALG is lim=
ited by
> +default. See :ref:`/proc/sys/crypto/af_alg_restrict <af_alg_restrict>`.
> +
> +On systems where no programs using AF_ALG remain, the support for it sho=
uld be
> +disabled entirely by setting ``/proc/sys/crypto/af_alg_restrict`` to 2 o=
r by
> +disabling ``CONFIG_CRYPTO_USER_API_*`` in the kernel configuration.
>
>  Deprecation
>  -----------
>
>  AF_ALG was originally intended to provide userspace programs access to c=
rypto
> diff --git a/crypto/af_alg.c b/crypto/af_alg.c
> index cce000e8590e..34b801568fba 100644
> --- a/crypto/af_alg.c
> +++ b/crypto/af_alg.c
> @@ -6,10 +6,11 @@
>   *
>   * Copyright (c) 2010 Herbert Xu <herbert@gondor.apana.org.au>
>   */
>
>  #include <linux/atomic.h>
> +#include <linux/capability.h>
>  #include <crypto/if_alg.h>
>  #include <linux/crypto.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/key.h>
> @@ -20,14 +21,32 @@
>  #include <linux/rwsem.h>
>  #include <linux/sched.h>
>  #include <linux/sched/signal.h>
>  #include <linux/security.h>
>  #include <linux/string.h>
> +#include <linux/sysctl.h>
> +#include <linux/user_namespace.h>
>  #include <keys/user-type.h>
>  #include <keys/trusted-type.h>
>  #include <keys/encrypted-type.h>
>
> +static int af_alg_restrict =3D 1;
> +
> +static const struct ctl_table af_alg_table[] =3D {
> +       {
> +               .procname       =3D "af_alg_restrict",
> +               .data           =3D &af_alg_restrict,
> +               .maxlen         =3D sizeof(int),
> +               .mode           =3D 0644,
> +               .proc_handler   =3D proc_dointvec_minmax,
> +               .extra1         =3D SYSCTL_ZERO,
> +               .extra2         =3D SYSCTL_TWO,
> +       },
> +};
> +
> +static struct ctl_table_header *af_alg_header;
> +
>  struct alg_type_list {
>         const struct af_alg_type *type;
>         struct list_head list;
>  };
>
> @@ -108,10 +127,43 @@ int af_alg_unregister_type(const struct af_alg_type=
 *type)
>
>         return err;
>  }
>  EXPORT_SYMBOL_GPL(af_alg_unregister_type);
>
> +static bool af_alg_capable(void)
> +{
> +       return ns_capable_noaudit(&init_user_ns, CAP_NET_ADMIN) ||
> +              capable(CAP_SYS_ADMIN);
> +}
> +
> +int af_alg_check_restriction(const char *name,
> +                            const struct af_alg_allowlist_entry allowlis=
t[])
> +{
> +       int level =3D READ_ONCE(af_alg_restrict);
> +
> +       if (level =3D=3D 0)
> +               return 0;
> +       if (level =3D=3D 1) {
> +               for (const struct af_alg_allowlist_entry *ent =3D allowli=
st;
> +                    ent->name; ent++) {
> +                       if (strcmp(name, ent->name) =3D=3D 0 &&
> +                           (!ent->privileged || af_alg_capable()))
> +                               return 0;
> +               }
> +       }
> +       /*
> +        * Use -ENOENT (the error code for "algorithm not found") instead=
 of
> +        * -EACCES or -EPERM, for the highest chance of correctly trigger=
ing
> +        * fallback code paths in userspace programs.
> +        *
> +        * Don't log a warning, since it would be noisy.  iwd tries to bi=
nd a
> +        * bunch of algorithms that it never uses.
> +        */
> +       return -ENOENT;
> +}
> +EXPORT_SYMBOL_GPL(af_alg_check_restriction);
> +
>  static void alg_do_release(const struct af_alg_type *type, void *private=
)
>  {
>         if (!type)
>                 return;
>
> @@ -504,10 +556,13 @@ static int alg_create(struct net *net, struct socke=
t *sock, int protocol,
>                       int kern)
>  {
>         struct sock *sk;
>         int err;
>
> +       if (READ_ONCE(af_alg_restrict) =3D=3D 2)
> +               return -EAFNOSUPPORT;
> +
>         if (sock->type !=3D SOCK_SEQPACKET)
>                 return -ESOCKTNOSUPPORT;
>         if (protocol !=3D 0)
>                 return -EPROTONOSUPPORT;
>
> @@ -1220,31 +1275,36 @@ int af_alg_get_rsgl(struct sock *sk, struct msghd=
r *msg, int flags,
>  }
>  EXPORT_SYMBOL_GPL(af_alg_get_rsgl);
>
>  static int __init af_alg_init(void)
>  {
> -       int err =3D proto_register(&alg_proto, 0);
> +       int err;
> +
> +       af_alg_header =3D register_sysctl("crypto", af_alg_table);
>
> +       err =3D proto_register(&alg_proto, 0);
>         if (err)
> -               goto out;
> +               goto out_unregister_sysctl;
>
>         err =3D sock_register(&alg_family);
> -       if (err !=3D 0)
> +       if (err)
>                 goto out_unregister_proto;
>
> -out:
> -       return err;
> +       return 0;
>
>  out_unregister_proto:
>         proto_unregister(&alg_proto);
> -       goto out;
> +out_unregister_sysctl:
> +       unregister_sysctl_table(af_alg_header);
> +       return err;
>  }
>
>  static void __exit af_alg_exit(void)
>  {
>         sock_unregister(PF_ALG);
>         proto_unregister(&alg_proto);
> +       unregister_sysctl_table(af_alg_header);
>  }
>
>  module_init(af_alg_init);
>  module_exit(af_alg_exit);
>  MODULE_DESCRIPTION("Crypto userspace interface");
> diff --git a/crypto/algif_aead.c b/crypto/algif_aead.c
> index 787aac8aeb24..b9217f9086aa 100644
> --- a/crypto/algif_aead.c
> +++ b/crypto/algif_aead.c
> @@ -32,10 +32,15 @@
>  #include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/net.h>
>  #include <net/sock.h>
>
> +static const struct af_alg_allowlist_entry aead_allowlist[] =3D {
> +       { "ccm(aes)", true }, /* bluez */
> +       {},
> +};
> +
>  static inline bool aead_sufficient_data(struct sock *sk)
>  {
>         struct alg_sock *ask =3D alg_sk(sk);
>         struct sock *psk =3D ask->parent;
>         struct alg_sock *pask =3D alg_sk(psk);
> @@ -342,10 +347,16 @@ static struct proto_ops algif_aead_ops_nokey =3D {
>         .poll           =3D       af_alg_poll,
>  };
>
>  static void *aead_bind(const char *name)
>  {
> +       int err;
> +
> +       err =3D af_alg_check_restriction(name, aead_allowlist);
> +       if (err)
> +               return ERR_PTR(err);
> +
>         return crypto_alloc_aead(name, 0, AF_ALG_CRYPTOAPI_MASK);
>  }
>
>  static void aead_release(void *private)
>  {
> diff --git a/crypto/algif_hash.c b/crypto/algif_hash.c
> index 5452ad6c1506..a8d958d51ece 100644
> --- a/crypto/algif_hash.c
> +++ b/crypto/algif_hash.c
> @@ -14,10 +14,28 @@
>  #include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/net.h>
>  #include <net/sock.h>
>
> +static const struct af_alg_allowlist_entry hash_allowlist[] =3D {
> +       { "cmac(aes)", true }, /* iwd, bluez */
> +       { "hmac(md5)", true }, /* iwd */
> +       { "hmac(sha1)", true }, /* iwd */
> +       { "hmac(sha224)", true }, /* iwd */
> +       { "hmac(sha256)", true }, /* iwd */
> +       { "hmac(sha384)", true }, /* iwd */
> +       { "hmac(sha512)", true }, /* iwd, sha512hmac */
> +       { "md4", true }, /* iwd */
> +       { "md5", true }, /* iwd */
> +       { "sha1", false }, /* iwd, iproute2 < 7.0 */
> +       { "sha224", true }, /* iwd */
> +       { "sha256", true }, /* iwd */
> +       { "sha384", true }, /* iwd */
> +       { "sha512", true }, /* iwd */
> +       {},
> +};
> +
>  struct hash_ctx {
>         struct af_alg_sgl sgl;
>
>         u8 *result;
>
> @@ -380,10 +398,16 @@ static struct proto_ops algif_hash_ops_nokey =3D {
>         .accept         =3D       hash_accept_nokey,
>  };
>
>  static void *hash_bind(const char *name)
>  {
> +       int err;
> +
> +       err =3D af_alg_check_restriction(name, hash_allowlist);
> +       if (err)
> +               return ERR_PTR(err);
> +
>         return crypto_alloc_ahash(name, 0, AF_ALG_CRYPTOAPI_MASK);
>  }
>
>  static void hash_release(void *private)
>  {
> diff --git a/crypto/algif_rng.c b/crypto/algif_rng.c
> index 4dfe7899f8fa..bd522915d56d 100644
> --- a/crypto/algif_rng.c
> +++ b/crypto/algif_rng.c
> @@ -48,10 +48,14 @@
>
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Stephan Mueller <smueller@chronox.de>");
>  MODULE_DESCRIPTION("User-space interface for random number generators");
>
> +static const struct af_alg_allowlist_entry rng_allowlist[] =3D {
> +       {},
> +};
> +
>  struct rng_ctx {
>  #define MAXSIZE 128
>         unsigned int len;
>         struct crypto_rng *drng;
>         u8 *addtl;
> @@ -199,10 +203,15 @@ static struct proto_ops __maybe_unused algif_rng_te=
st_ops =3D {
>
>  static void *rng_bind(const char *name)
>  {
>         struct rng_parent_ctx *pctx;
>         struct crypto_rng *rng;
> +       int err;
> +
> +       err =3D af_alg_check_restriction(name, rng_allowlist);
> +       if (err)
> +               return ERR_PTR(err);
>
>         pctx =3D kzalloc_obj(*pctx);
>         if (!pctx)
>                 return ERR_PTR(-ENOMEM);
>
> diff --git a/crypto/algif_skcipher.c b/crypto/algif_skcipher.c
> index df20bdfe1f1f..2b8069667974 100644
> --- a/crypto/algif_skcipher.c
> +++ b/crypto/algif_skcipher.c
> @@ -32,10 +32,24 @@
>  #include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/net.h>
>  #include <net/sock.h>
>
> +static const struct af_alg_allowlist_entry skcipher_allowlist[] =3D {
> +       { "adiantum(xchacha12,aes)", false }, /* cryptsetup */
> +       { "adiantum(xchacha20,aes)", false }, /* cryptsetup */
> +       { "cbc(aes)", true }, /* iwd */
> +       { "cbc(des)", true }, /* iwd */
> +       { "cbc(des3_ede)", true }, /* iwd */
> +       { "ctr(aes)", true }, /* iwd */
> +       { "ecb(aes)", true }, /* iwd, bluez */
> +       { "ecb(des)", true }, /* iwd */
> +       { "hctr2(aes)", false }, /* cryptsetup */
> +       { "xts(aes)", false }, /* cryptsetup benchmark */
> +       {},
> +};
> +
>  static int skcipher_sendmsg(struct socket *sock, struct msghdr *msg,
>                             size_t size)
>  {
>         struct sock *sk =3D sock->sk;
>         struct alg_sock *ask =3D alg_sk(sk);
> @@ -307,10 +321,16 @@ static struct proto_ops algif_skcipher_ops_nokey =
=3D {
>         .poll           =3D       af_alg_poll,
>  };
>
>  static void *skcipher_bind(const char *name)
>  {
> +       int err;
> +
> +       err =3D af_alg_check_restriction(name, skcipher_allowlist);
> +       if (err)
> +               return ERR_PTR(err);
> +
>         return crypto_alloc_skcipher(name, 0, AF_ALG_CRYPTOAPI_MASK);
>  }
>
>  static void skcipher_release(void *private)
>  {
> diff --git a/include/crypto/if_alg.h b/include/crypto/if_alg.h
> index 7643ba954125..4e9ed8e73403 100644
> --- a/include/crypto/if_alg.h
> +++ b/include/crypto/if_alg.h
> @@ -159,13 +159,21 @@ struct af_alg_ctx {
>         unsigned int len;
>
>         unsigned int inflight;
>  };
>
> +struct af_alg_allowlist_entry {
> +       const char *name;
> +       bool privileged;
> +};
> +
>  int af_alg_register_type(const struct af_alg_type *type);
>  int af_alg_unregister_type(const struct af_alg_type *type);
>
> +int af_alg_check_restriction(const char *name,
> +                            const struct af_alg_allowlist_entry allowlis=
t[]);
> +
>  int af_alg_release(struct socket *sock);
>  void af_alg_release_parent(struct sock *sk);
>  int af_alg_accept(struct sock *sk, struct socket *newsock,
>                   struct proto_accept_arg *arg);
>
>
> base-commit: 1dc18801be29bc54709aa355b8acd80e183b03cd
> --
> 2.54.0
>
>


--=20
Luiz Augusto von Dentz
