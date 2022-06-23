Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3111FB2
	for <iwd@lists.linux.dev>; Thu, 23 Jun 2022 16:47:51 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id 184so19656460pga.12
        for <iwd@lists.linux.dev>; Thu, 23 Jun 2022 09:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=zqMsF4gVS95F5bRqOY6QKLn9DEbm4kBNqjsQaJj6720=;
        b=lyRNJm2bPTvY+FL6/vJB30o5OMuB6AEfelocYsRY9Qj0M4IOfQVWggUcL1Zs+J7f/7
         +N+e5aiH4lC1QX82UTNDGI3y4HHOojWQ4VIndllnv4KwGIxGpGA1UmvRvwuRNB5DGcMk
         8yCrMwrDoN9g06NUNCQPbxvtGPQYDBhvc+fOMaZrQuKHDBrlz0nojDASBDcyBzM5uFaA
         9r9IlDOvT3xH3U1Dv1AFVh5guzokT8JDbrrHN5WUlmLchzTttXTKMZO/IoJ/Ot6jii/J
         vFVA2lMelD12FuPbIKhyfKQBCQ5sAhJHzlqXlbbSkYUTo5mDc/LWWea+lVmzXZ8hEos+
         B6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=zqMsF4gVS95F5bRqOY6QKLn9DEbm4kBNqjsQaJj6720=;
        b=oL3aiE13vieHZh8efUbz8rh6+F4v06ZkELish8Wti6+9Sd4qi6iRQZ0LDK/mIvX9pi
         jlpK75mJ/kcIXuf6LT6/4cGNMYe+fmCVr5KNpzxpARam3WNpbKpXz7MW9SJRoMoUEozr
         tXHOpyad650jh4+RVLRiHQ6HTc9Z2zK3yCy46h9xnk37xGiJ6ZCE0nmqPhJeqqFJzNDv
         kK4JF4DSy8AsD5/9bPgNhczpKitCTu8rok5+0TxClFe6wUj1y5NHhvE3vV9kw+OVw359
         8WEgqMAISTaRXM5orcIlrQ4YSWpkeZr6TqSW1ahMIlxZUnsBfFyyfNPeEE5EVOGRS2EA
         /Kug==
X-Gm-Message-State: AJIora/6HPUCF/64vbSpfaJ76XlGMohXdQWQ5X1kvOh8tNITE2c6kOzR
	yIMKpzNf7b8lpkn9LvjfpAL+z0iPzr0=
X-Google-Smtp-Source: AGRyM1vp9qRM3MOAl2fNw2qs95uurAk3tlhnMu3wo4ZnEBTRrbXXHl+YzgYP6u528cM3n1lzoHbsIg==
X-Received: by 2002:a05:6a00:17a8:b0:525:537a:b0df with SMTP id s40-20020a056a0017a800b00525537ab0dfmr5197914pfg.71.1656002870983;
        Thu, 23 Jun 2022 09:47:50 -0700 (PDT)
Received: from [192.168.254.55] ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id n24-20020a170902969800b0016a034ae481sm13499plp.176.2022.06.23.09.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 09:47:50 -0700 (PDT)
Message-ID: <b7ea87b9c85a5bd6c4d6d21548d6db3ebd2f6274.camel@gmail.com>
Subject: Re: [PATCH 2/2] doc: Add State and Role properties to DPP API
From: James Prestwood <prestwoj@gmail.com>
To: Jesse Lentz <jesse@twosheds.org>, iwd@lists.linux.dev
Date: Thu, 23 Jun 2022 09:47:50 -0700
In-Reply-To: <CKXNNPV68RR1.3ROOO4K1DSKL0@laptop>
References: <20220622194142.213135-1-jesse@twosheds.org>
	 <20220622194142.213135-2-jesse@twosheds.org>
	 <312b2cd5fdede0d7fdd7f45aeda5919e9b22950f.camel@gmail.com>
	 <CKXNNPV68RR1.3ROOO4K1DSKL0@laptop>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-3.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jesse,

On Thu, 2022-06-23 at 12:30 -0400, Jesse Lentz wrote:
> Hi James,
> 
> Thanks for your feedback.
> 
> > > +Properties     string State [readonly, optional]
> > > +
> > > +                       Reflects the DPP state. Possible values
> > > are
> > > "presence",
> > > +                       "authenticating", and "configuring".
> > 
> > I think a "stopped" state would also be needed.
> 
> As a user of the API, I can infer that DPP is inactive if "State" is
> undefined. A non-optional State property with an explicit "inactive"
> value should provide equivalent information; would you prefer the
> latter
> approach?

Yeah, I think having an explicit value is best. I think it makes it
easier to handle for the consumer of the API.

> 
> > > +               string Role [readonly, optional]
> > > +
> > > +                       Reflects the DPP role. Possible values
> > > are
> > > "enrollee"
> > > +                       and "configurator"
> > 
> > I don't think you actually need this one. The role should be
> > implied by
> > however you started DPP:
> > 
> > StartEnrollee() -> enrollee
> > StartConfigurator() -> configurator
> > ConfigureEnrollee() -> configurator
> 
> One use case that I'm trying to address is when a user launches the
> front-end app while DPP is already active. There are two ways that I
> can
> think of to handle this:

Ah, ok this is fine then. Having the property would be the simplest way
to handle this case.

> 
> 1) The front-end stops and re-starts DPP if the user requests it.
> This
> only requires iwd to provide State, so that the front-end can see if
> a
> previous invocation must be stopped.
> 
> 2) iwd provides sufficient information via properties to restore the
> previous invocation: State, Role, and URI.
> 
> I originally had option 2 in mind, but if DPP invocations are
> intended
> to be transient, then perhaps option 1 would be more appropriate. Let
> me
> know what your thoughts are, and I'll send a revised patch.

Out of curiosity do you need these properties purely for displaying to
the user? If so I wonder if they shoud go on a new interface, e.g.
DeviceProvisioningDiagnostics.

We have a similar concept with AccessPointDiagnostics and
StationDiagnostics. These interfaces hold extra information that isn't
really needed to use IWD generally, but more debugging or displaying
information in a UI. These seem to fit more into that category than
needed for DPP in general.

> 
> Thanks.
> 
> Sincerely,
> Jesse


