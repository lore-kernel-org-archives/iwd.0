Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1438F1EF385
	for <iwd@lists.linux.dev>; Fri, 28 Feb 2025 15:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756129; cv=none; b=fA7WBrcvYtlEyWmY31kbjLANMguCnktDzBwiIqtW8RklVznk8uMsjROX6+JiV9ByP1BBY+ePSYqaNJjD5UKroufzf8cL1tlPROcOdYf0mxSgSQnVQSMXCgZeUbw0rOTtt/T9MJLq+Qbfp3+XwNQ338yO+RRD6sZlwxMvJ1KBOyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756129; c=relaxed/simple;
	bh=TrZhN+Sc9Y8bFa0flIaJWqp0mWhu505fvwh/Fe4Og30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TCefBMjKL/FDZbb0AgX4IjEMQFQ1qFqmee+Elm8Gy6LcUXp0bNeeR4j3iiRJkl5CuLdCAhAst639KaW2UWqTM5zmYQFWS4xQTMUB7tOlvS2LPD7zjP0znhvlVeNnxBIUSs7lj/kA9GzZFLkOpuvRLBFSf9ACABRZXuYEz3aIwoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6efe4e3d698so20452977b3.0
        for <iwd@lists.linux.dev>; Fri, 28 Feb 2025 07:22:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740756127; x=1741360927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWr3G6Y1CienmsmC+x2X15XdGlGC84ptnM7iQB/LFEo=;
        b=rkwAMSrhGbNyRjqoNPPEK92fK2LYigPTGO8U4uRkrMCdcH4czxWJsSf3lBiDcRYrPh
         xcVNFBOTAlUaajEMcKR5NZfuroCV/RNAbiVIpFvzoxvtnACX9DFwg8EhPNUu/elgP8MG
         wx2Chkd/leD3b4gbASX2kFezdC4mfrPWlVKS/XrM4n4Lscm84WEPtueZ0iyWSYBJ6seg
         vaKwErbyAQqPUxiXiWfTxzDzST9hHl/YxyiHOo/TzB2j1AqF26BcP5TpwDmgp+osaTQ2
         rF1oSBKhLTCbHD3XA/vlDYnd9Dp/Tld1Y7LhYT2ixfu+vXz09AkGO9m3qnzoSSd75TOF
         o4jQ==
X-Gm-Message-State: AOJu0YwofUnokUHB6esNfNThHx/esChoC2ETUWGbjaSMRj7x9h+JAXC3
	bkKwc04dd26tVfYURB18Uely/1f+XyvbEEohzHi9PptdF2lsdBpVIfzQfA==
X-Gm-Gg: ASbGncusvU50Es0daQioFnt3uwWClSQUkTKojaJJPCics8T/6awgIeZAajY/9SzJfpq
	A00l2wD2URnhIYkMuGG4p15hIUb3MRvpkVsCi/i6Y/DM4m/sZHFBZtWtjjL5ErMMXuYoqM4HCvM
	O4SgF/c2BTebVDCNqjLTXITBQ5G0xe46jqnMehwMLEuAZn3bYUF+XEYG1AAX7y3OrHQrSsRCJDS
	1wQ+tbh+E3SocqOVZO40JWCPShwhAnzqtEEfGr1BybiGaPnVMYlzzpChD1LF1iPtwJT+3VD/maE
	Sqd5cHLLEmdSIV26elnOaH0/8aIcLms0bYApMDbxUzb1JZY3viragki/xLx2y5t5UL8xMQ==
X-Google-Smtp-Source: AGHT+IGb2eCiCGFKd71EGtKwlxIpSXQl12hR2oz5kggsj9clPw609lpDxGA3TXWPLT3tRzugdTagrA==
X-Received: by 2002:a05:690c:6912:b0:6ee:5cf9:f898 with SMTP id 00721157ae682-6fd4a16f893mr55537227b3.33.1740756126808;
        Fri, 28 Feb 2025 07:22:06 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fd3ca4889bsm7692987b3.49.2025.02.28.07.22.06
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 07:22:06 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6fb9dae0125so20030557b3.1
        for <iwd@lists.linux.dev>; Fri, 28 Feb 2025 07:22:06 -0800 (PST)
X-Received: by 2002:a05:690c:4b02:b0:6fd:2587:cb32 with SMTP id
 00721157ae682-6fd4a16c199mr55277387b3.31.1740756126401; Fri, 28 Feb 2025
 07:22:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADXxVS+UQfrbWFfsDnW1QvkpvmEnkxMdv+OPBy=XpPXEFdcU8Q@mail.gmail.com>
 <2c244463-921e-42bc-8618-aea86e28d075@gmail.com>
In-Reply-To: <2c244463-921e-42bc-8618-aea86e28d075@gmail.com>
From: Bryce Johnson <bryce@redpinelabs.com>
Date: Fri, 28 Feb 2025 08:21:55 -0700
X-Gmail-Original-Message-ID: <CADXxVS+=KgaaehtvzQUZXcECmGquvdkAiqUuRPnCmugdU0MqWw@mail.gmail.com>
X-Gm-Features: AQ5f1JqhPwMfGC_9yqAarFf2gW4P7K5hyehR--aZOwkREJ7yeXty2pTszJDbJxw
Message-ID: <CADXxVS+=KgaaehtvzQUZXcECmGquvdkAiqUuRPnCmugdU0MqWw@mail.gmail.com>
Subject: Re: [RFC] netconfig: Global option to send hostname with dhcp request
 for all networks
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 6:58=E2=80=AFAM James Prestwood <prestwoj@gmail.com=
> wrote:
>
> Hi Bryce,
>
> On 2/27/25 1:42 PM, Bryce Johnson wrote:
> > Add global option to send hostname with dhcp always with
> > [IPv4].SendHostnameAlways so the first DHCP request will include the
> > hostname on first connection and don't need to modify the .psk files
> > to add SendHostname after they are created.
> >
> > ---
> > diff --git a/src/iwd.config.rst b/src/iwd.config.rst
> > index 4ba7b4e7..4f473e07 100644
> > --- a/src/iwd.config.rst
> > +++ b/src/iwd.config.rst
> > @@ -429,6 +429,11 @@ The group ``[IPv4]`` contains settings related to
> > IPv4 network configuration.
> >          will limit the number of access points that can be running
> >          simultaneously on different interfaces.
> >
> > +   * - SendHostnameAlways
> > +     - Values: true, **false**
> > +
> > +       Always send the hostname in the DHCP request for all networks.
> NIT: You could probably just shorten this to "SendHostname". I
> personally don't mind if settings have the same name between main.conf
> and network profiles.

Thanks for the review. I'll push up a new patch.  Looks like I
probably should have done it in 2 patches, one for the doc and one for
the netconfig?  Is there an order of preference if in the main.conf
SendHostname is true, but in the psk it is false?  I assume the psk
one should take preference?
> > +
> >   DriverQuirks
> >   ------------
> >
> > diff --git a/src/netconfig.c b/src/netconfig.c
> > index cd19217c..5959a5ac 100644
> > --- a/src/netconfig.c
> > +++ b/src/netconfig.c
> > @@ -375,7 +375,9 @@ gateway:
> >      }
> >
> >   send_hostname:
> > -   if (l_settings_has_key(active_settings, "IPv4", "SendHostname") &&
> > +   l_settings_get_bool(iwd_get_config(), "IPv4",
> > "SendHostnameAlways", &send_hostname);
> > +
> > +   if (!send_hostname && l_settings_has_key(active_settings, "IPv4",
> > "SendHostname") &&
> >              !l_settings_get_bool(active_settings, "IPv4",
> >                          "SendHostname",
> >                          &send_hostname)) {
> > @@ -391,13 +393,20 @@ send_hostname:
> >          goto mdns;
> >      }
> >
> > -   if (send_hostname &&
> > -           !l_netconfig_set_hostname(netconfig->nc, hostname)) {
> > -       l_error("netconfig: l_netconfig_set_hostname() failed");
> > -       success =3D false;
> > -       goto mdns;
> > +   if (send_hostname) {
> > +       if (!l_netconfig_set_hostname(netconfig->nc, hostname)) {
> > +           l_error("netconfig: l_netconfig_set_hostname() failed");
> > +           success =3D false;
> > +       } else {
> > +           l_debug("netconfig: Hostname '%s' will be sent in DHCP
> > requests", hostname);
> > +       }
> > +   } else {
> > +       l_debug("netconfig: No hostname will be sent in DHCP requests")=
;
> It probably seemed consistent, but l_error() actually doesn't include
> the file/function which is why those all have "netconfig:" in them. For
> debug prints we actually don't need to prefix with "netconfig:" since it
> will always include the file and function name.

Will fix this as well.

> >      }
> >
> > +   goto mdns;
> > +
> > +
> >   mdns:
> >      /* If the networks has this set take that over the global */
> >      if (l_settings_has_key(active_settings, "Network", "MulticastDNS")=
) {
> >
> Thanks,
>
> James
>
