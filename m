Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB917C
	for <iwd@lists.linux.dev>; Thu,  7 Jul 2022 23:11:39 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id m18so15148470lfg.10
        for <iwd@lists.linux.dev>; Thu, 07 Jul 2022 16:11:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RmfrIkLZ4Hm8BD2ZkUUDlpX37KQo4LfQMNDsrOlKwBc=;
        b=ZhUlKrtq00YmNqSikKr3bJhJuuaKtQRt4pabk6ulDk7TvSV8wyvCx/9K/JLwjACm6l
         +NcA3RUVub9/awEpABdJrfcSI7PP+3+1QeNhNyNlTDnyGp85xJ6ktgIEEKQSzLDuBXml
         eNdq4WPKJvdkTZrNL0taTcWBIzNnojDrfO2cvEtKcOCneBstr2DOqPyeZfvD64J7hcRM
         dWLNTBw16RazJB7q1UKKAOIA6eSfQVofsF3ENK/E1QnKaaXLfayluWVcpBMDQyrIECpD
         XVbwXm4DE8Jl2D2abspzDjKVx7JfA9iqPHLm1zZBFcujVydg6h7nTudJzbIM1Zio9C86
         Z8rA==
X-Gm-Message-State: AJIora8tkSSz4wBvwKDN5bLFwQ+OHvrM2DxFKB572V3UqfX/c58L/wkd
	AbuZ1DiYXtplYJQIvscZte2TlbB6DHTP9pI9
X-Google-Smtp-Source: AGRyM1sVLa24imTDDOnLkb0phRph0QQppvdJprqKKwWgeqT8Kq8PT85R2R5vWd8ZmTT4h+gAyOxuWw==
X-Received: by 2002:a05:6512:150e:b0:481:60af:a5a5 with SMTP id bq14-20020a056512150e00b0048160afa5a5mr382455lfb.524.1657235497842;
        Thu, 07 Jul 2022 16:11:37 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id k14-20020ac2456e000000b0047f706e018bsm7073113lfm.13.2022.07.07.16.11.37
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 16:11:37 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id bf9so10376509lfb.13
        for <iwd@lists.linux.dev>; Thu, 07 Jul 2022 16:11:37 -0700 (PDT)
X-Received: by 2002:a05:6512:2508:b0:480:f1cb:64ad with SMTP id
 be8-20020a056512250800b00480f1cb64admr391977lfb.359.1657235497040; Thu, 07
 Jul 2022 16:11:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220707200309.3276163-1-andrew.zaborowski@intel.com> <444493cc8338b6b8ac9e0a0a3149ea3ef55fd76f.camel@gmail.com>
In-Reply-To: <444493cc8338b6b8ac9e0a0a3149ea3ef55fd76f.camel@gmail.com>
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Date: Fri, 8 Jul 2022 01:11:25 +0200
X-Gmail-Original-Message-ID: <CAOq732KGfw5_JkjDh09W0Jp6CfcECLweifFCEY1iCAXZ6kX+Lw@mail.gmail.com>
Message-ID: <CAOq732KGfw5_JkjDh09W0Jp6CfcECLweifFCEY1iCAXZ6kX+Lw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] test-runner: Support running hostapd in namespaces
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi James,

On Fri, 8 Jul 2022 at 00:37, James Prestwood <prestwoj@gmail.com> wrote:
> On Thu, 2022-07-07 at 22:03 +0200, Andrew Zaborowski wrote:
> >  class Interface:
> > -       def __init__(self, name, config):
> > +       def __init__(self, name, config, ns=None):
> >                 self.name = name
> >                 self.ctrl_interface = '/var/run/hostapd/' + name
> >                 self.config = config
> > +               self.ns = ns
> >
> >         def __del__(self):
> > -               Process(['iw', 'dev', self.name, 'del']).wait()
> > +               Process(['iw', 'dev', self.name, 'del'],
> > +                               namespace=self.ns.name if self.ns
> > else None).wait()
> >
> >         def set_interface_state(self, state):
> > -               Process(['ip', 'link', 'set', self.name,
> > state]).wait()
> > +               Process(['ip', 'link', 'set', self.name, state],
> > +                               namespace=self.ns.name if self.ns
> > else None).wait()
> >
>
> So rather than this "self.ns.name if self.ns else None" thing, you
> could either store the namespace name directly (since self.ns is only
> used for the name), or store the namespace object like you do and
> replace Process(...) with self.ns.start_process(...).

Ok, either of those should work, or maybe make sure Radios and
Interfaces are initalized with "ctx" as the namespace so self.ns is
never None.

>
> >  class Radio:
> >         def __init__(self, name):
> > @@ -75,11 +78,16 @@ class Radio:
> >                 # hostapd will reset this if this radio is used by it
> >                 self.use = 'iwd'
> >                 self.interface = None
> > +               self.ns = None
> >
> >         def __del__(self):
> >                 print("Removing radio %s" % self.name)
> >                 self.interface = None
> >
> > +       def set_namespace(self, ns):
> > +               self.ns = ns
> > +               Process(['iw', 'phy', self.name, 'set', 'netns',
> > 'name', ns.name]).wait()
> > +
> >         def create_interface(self, config, use):
> >                 global intf_id
> >
> > @@ -87,19 +95,21 @@ class Radio:
> >
> >                 intf_id += 1
> >
> > -               self.interface = Interface(ifname, config)
> > +               self.interface = Interface(ifname, config,
> > ns=self.ns)
> >                 self.use = use
> >
> >                 Process(['iw', 'phy', self.name, 'interface', 'add',
> > ifname,
> > -                               'type', 'managed']).wait()
> > +                               'type', 'managed'],
> > namespace=self.ns.name if self.ns else None).wait()
> >
> >                 return self.interface
>
> Since create_interface() is the only function that needs the namespace
> couldn't we remove set_namespace entirely and just pass the namespace
> name into create_interface?

So set_namespace() also moves the radio to the right namespace.  We
need this for radios used by both hostapd and IWD, where we don't use
create_interface().

I also think it's nice if you can obtain the namespace reference from
`radio.ns` or `interface.ns`, say, in autotests/util/*.py code or
elsewhere.

>
> > +       def get_hapd_instance(self, config=None):
> > +               instances = [i for hapd in self.hostapd for i in
> > hapd.instances]
> > +
> > +               if config is None:
> > +                       return instances[0]
> > +
> > +               for hapd in instances:
> > +                       if hapd.config == config:
> > +                               return hapd
> > +
>
> Looks like this got carried over from that dropped patch?

I use this in autotests/util/hostapd.py (patch 2/4) since ctx.hostapd
is now a list and to override the [] operator you'd need to subclass
the list and overall it's simpler this way.

Thanks for the review,
Best regards
