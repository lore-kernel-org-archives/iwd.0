Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539967C
	for <iwd@lists.linux.dev>; Thu,  7 Jul 2022 23:19:27 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id z1so9158999plb.1
        for <iwd@lists.linux.dev>; Thu, 07 Jul 2022 16:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=kKwscGiiiRSzzYeKRqD46U6qTBnnV6eq6V396obZv20=;
        b=OWM7Q/n9EEYhR1mEWj8anOj6O2qfvNBwKfwwPY83eR23OS3jxhyeFnVZuMLBZWshi5
         oJHihxl49N3Cl44v/DvhV1beXzF16zfKZCCFBXqTWvYfshPbTSxn1cYhGfMLD7/B2Wdr
         hv/AvIVf+7EwjbxVWE6jNxtO9qxO62PQK2/oW9MCrDtbN0tjwq+1tZwsNhHprUl+/7Lx
         t5Fb+qkE05dqmVUmkDvh4lCLc5KLydOv/xN1BqdftFPmEnbaex40kHBriGsLuILpz6Y9
         9J3STUziL+FigMLnvhmWDk9l4ppC+Pgpc9+McMfaSShi9UbwKEDGcfYSXHFHubMpr/9M
         dweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=kKwscGiiiRSzzYeKRqD46U6qTBnnV6eq6V396obZv20=;
        b=gM4HWfIXrc1GL2UTLvqR0OtI83beCd8CxhqEJngqkcHZiZ9B3tfu2wq6MNcWtMzEHN
         3g4yCwyOnobCgIw8xHKlv2iQl+8TUQdRmnwe5DfJEyG8t0B+8PZNE3dBePL/QTiFU74w
         0g+rPqQsOYG3dOyLUzgoQl5CXNbIioHx7SgYxiMdLLWHg0cxG50BLVyFfpqB22Kp/hcy
         fEw707MPsHEBoC+EMgPzxeT8BuKdbyDlQm2g/epWZBzH+miJquzRVGNmv1GrM0U7DKQf
         Szc3YDFFfZ4iRstHOPVPw7r/kDc+ZV9IIMAg5ZDREWNWiGHsYrKxsLlmsDacOfJXiJi4
         LXTQ==
X-Gm-Message-State: AJIora8hnxorsMCKiAf8euYCx47AimhHSJXTGEgJVNmzMkKvuMKtNlpq
	dRqhsgzddE01vrtzh+hJfoY=
X-Google-Smtp-Source: AGRyM1vVegVJJFCEuPuzPxGx+epa4/7dA+H45C5Jn4708SfqwRLyXmTcX23wBTxl3lnNiTc4p0SPpg==
X-Received: by 2002:a17:903:4094:b0:16b:df0e:6312 with SMTP id z20-20020a170903409400b0016bdf0e6312mr488788plc.61.1657235966696;
        Thu, 07 Jul 2022 16:19:26 -0700 (PDT)
Received: from [192.168.254.55] ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id bk21-20020aa78315000000b005254e44b748sm27236101pfb.84.2022.07.07.16.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 16:19:26 -0700 (PDT)
Message-ID: <fc33625c8f1531df696fbc07099f16e71f7b4a86.camel@gmail.com>
Subject: Re: [PATCH v2 1/4] test-runner: Support running hostapd in
 namespaces
From: James Prestwood <prestwoj@gmail.com>
To: Andrew Zaborowski <andrew.zaborowski@intel.com>
Cc: iwd@lists.linux.dev
Date: Thu, 07 Jul 2022 16:19:25 -0700
In-Reply-To: <CAOq732KGfw5_JkjDh09W0Jp6CfcECLweifFCEY1iCAXZ6kX+Lw@mail.gmail.com>
References: <20220707200309.3276163-1-andrew.zaborowski@intel.com>
	 <444493cc8338b6b8ac9e0a0a3149ea3ef55fd76f.camel@gmail.com>
	 <CAOq732KGfw5_JkjDh09W0Jp6CfcECLweifFCEY1iCAXZ6kX+Lw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-3.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,
> > >  class Radio:
> > >         def __init__(self, name):
> > > @@ -75,11 +78,16 @@ class Radio:
> > >                 # hostapd will reset this if this radio is used
> > > by it
> > >                 self.use = 'iwd'
> > >                 self.interface = None
> > > +               self.ns = None
> > > 
> > >         def __del__(self):
> > >                 print("Removing radio %s" % self.name)
> > >                 self.interface = None
> > > 
> > > +       def set_namespace(self, ns):
> > > +               self.ns = ns
> > > +               Process(['iw', 'phy', self.name, 'set', 'netns',
> > > 'name', ns.name]).wait()
> > > +
> > >         def create_interface(self, config, use):
> > >                 global intf_id
> > > 
> > > @@ -87,19 +95,21 @@ class Radio:
> > > 
> > >                 intf_id += 1
> > > 
> > > -               self.interface = Interface(ifname, config)
> > > +               self.interface = Interface(ifname, config,
> > > ns=self.ns)
> > >                 self.use = use
> > > 
> > >                 Process(['iw', 'phy', self.name, 'interface',
> > > 'add',
> > > ifname,
> > > -                               'type', 'managed']).wait()
> > > +                               'type', 'managed'],
> > > namespace=self.ns.name if self.ns else None).wait()
> > > 
> > >                 return self.interface
> > 
> > Since create_interface() is the only function that needs the
> > namespace
> > couldn't we remove set_namespace entirely and just pass the
> > namespace
> > name into create_interface?
> 
> So set_namespace() also moves the radio to the right namespace.  We
> need this for radios used by both hostapd and IWD, where we don't use
> create_interface().
> 
> I also think it's nice if you can obtain the namespace reference from
> `radio.ns` or `interface.ns`, say, in autotests/util/*.py code or
> elsewhere.


Are there situations where hostapd and IWD share a radio?

But I agree, its nice knowing what namespace a radio/interface belongs
to.

> 
> > 
> > > +       def get_hapd_instance(self, config=None):
> > > +               instances = [i for hapd in self.hostapd for i in
> > > hapd.instances]
> > > +
> > > +               if config is None:
> > > +                       return instances[0]
> > > +
> > > +               for hapd in instances:
> > > +                       if hapd.config == config:
> > > +                               return hapd
> > > +
> > 
> > Looks like this got carried over from that dropped patch?
> 
> I use this in autotests/util/hostapd.py (patch 2/4) since ctx.hostapd
> is now a list and to override the [] operator you'd need to subclass
> the list and overall it's simpler this way.


Sorry, I was confusing this with the HostapdCLI stuff. Nevermind.

> 
> Thanks for the review,
> Best regards



