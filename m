Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54C01CFBC
	for <iwd@lists.linux.dev>; Tue, 16 Apr 2024 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713281702; cv=none; b=GmBR+fCr1WBvpujy2VTPTllRD8FbQVtB+A9+kPrX7bL2mJQTS3fqo3+Rp1bg6fbhffls1m/bm8fIkzusiXr4ZyiHj6NvVlzLqblzUxTEKw78gjLQoEoHmfcd0TLumxy4rNcKA6geylbKpyw47BUkMoFhgcsWAEQiVwB0AR3jnr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713281702; c=relaxed/simple;
	bh=sWX4PaolRNuWEKXiBeeXqSQHLZeWDlxKBlQJbdazgkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iPUTpchT2C9It3gj1z8t0shGfW9KKSfahlUxvi/Tn8UD6geLy6w6D6T5slxny21E7SjC1fkMBvMZKuNr2SjjpdouVWa+P3HcONGNS/EF9cJ20keAt/YqWgjt0oOmWbDDilI+VbeSfHzliO6aWm2lzMmbCJbi1HrPUyIJJY5NG/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPnvhwlV; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPnvhwlV"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78d57bd5781so328133285a.3
        for <iwd@lists.linux.dev>; Tue, 16 Apr 2024 08:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713281700; x=1713886500; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=si2ea4LG8uO32+WkSp6YhaVLYB10Z4hK5uxpJcAqSE8=;
        b=gPnvhwlVaXbEfCGrl1Qr6Hy3MFFkOztyK9wFrDwJ5zmsAbaL0wuiXSiOJltR8JM8+d
         wPKguv2dXv2T2BSnsN0WEJfmEiexOCs/j8CuJ7aaEnYqx2tagxW5LaMy0Il2jGW82ot4
         +aW2NUE5wQXVC5kR1cNDItXmlEJvFAVc75ORw0NLEfHcuSo2niY6LVOR3wdaGi1jSZdW
         8ivTWwUXh/QKK1QlmusGQ/hNbN73XNIXXlut7i/WBT2WvPARTwYDpIXGwGZ5psBdI6dK
         20oIzhl/DRWZNOA7yBZMlPfa4Knt9F7ENL3nc7XNsYeUETEMkM0ajrZzFM5gotqF+vXA
         OvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713281700; x=1713886500;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=si2ea4LG8uO32+WkSp6YhaVLYB10Z4hK5uxpJcAqSE8=;
        b=fs6BD8QN1EhjI4D/X1MZY83UVQFanOv8v2FhaXybwmAoo8wcJqTsLxk3XuxM6mc/hR
         cUudRhdiG/jOu19ivaBWVu08p0y4q8I5mNAiNLsnu3FVCDFtmMGAGp+mwGsedk9LWdll
         Txk13xnZrAMT8Oj66CM91tiYoRPmbovOl6xhcJQ9KxLz36glo25xzZcvxRF6lZ67HGOa
         fndAAtF025EE/DdMwrSJokrRuDnr4TQqvxbn+FkUVHLgezSBYkhtMl5joDF828H5g3EV
         tvsfgu5oH+zH9CRK2zsn1rBMAF8/Swaj3qSAl5zzMURyEivQCQY4rCg4nGBRbgS1JN5X
         Szeg==
X-Forwarded-Encrypted: i=1; AJvYcCXdB5ZqdudUesDnAFzf3KbFaxOVjT/5lnuecEMJSjMk4LUwG3ApnWIkSUpuq9i8fDI9UtxkXyUNAb246d/V/WUMrTQn
X-Gm-Message-State: AOJu0YzdDEN524rOyGa8XbNQwzSPgtfy30fbSoZKXTwzzcg+78gksnIP
	OIJiYnB8r3DeldXt9HZr9YT1+Hu7lcTLeSUHD5gPDuNaoUXP8HPH2Usgmg==
X-Google-Smtp-Source: AGHT+IGIeZa7cG6PYUus9TrddnBhRUzvmsvHSaX3V1KSMRyUry3/wLbHrLFmQ2EEmDqVnY/dysGeaA==
X-Received: by 2002:a05:620a:2624:b0:78e:d3ae:bf6c with SMTP id z36-20020a05620a262400b0078ed3aebf6cmr14016248qko.78.1713281699670;
        Tue, 16 Apr 2024 08:34:59 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id pj39-20020a05620a1da700b0078ed3667cb8sm5332435qkn.124.2024.04.16.08.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 08:34:59 -0700 (PDT)
Message-ID: <35726d4d-ac32-45f3-a56a-c91d956f8a53@gmail.com>
Date: Tue, 16 Apr 2024 08:34:57 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NT/VHT errors filling log
Content-Language: en-US
To: KeithG <ys3al35l@gmail.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <CAG17S_OZt84p8HQ4E189+VTMssSrDBDXNzeMUT_hZb=jbuKE6Q@mail.gmail.com>
 <7978cd1a-8122-4b6b-9e38-b7d65a9c393e@gmail.com>
 <8c99082f-fa0d-4c9f-87ab-e49dc9e0f497@gmail.com>
 <558f87c3-7f6f-4c9b-9ff0-42f261f13ef3@gmail.com>
 <82b55e12-5f9b-4b31-b44f-18b8de4fce14@gmail.com>
 <CAG17S_PvKeP98kDwBEfAVJg7nRDH50HgsxYZ-YXD6wL6AnQN5A@mail.gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAG17S_PvKeP98kDwBEfAVJg7nRDH50HgsxYZ-YXD6wL6AnQN5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Keith,

On 4/16/24 7:16 AM, KeithG wrote:
> James,
>
> The messages have changed with the latest build.
> Apr 16 05:24:30 kitchenrune iwd[1490859]: invalid HE capabilities for 
> ac:ec:85:ab:10:d4
> Apr 16 05:53:31 kitchenrune iwd[1490859]: invalid HE capabilities for 
> d8:07:b6:8e:97:7b
> Apr 16 05:58:23 kitchenrune iwd[1490859]: invalid HE capabilities for 
> d8:07:b6:8e:97:7b
> Apr 16 06:22:23 kitchenrune iwd[1490859]: invalid HE capabilities for 
> d8:07:b6:8e:97:7b
> Apr 16 06:53:26 kitchenrune iwd[1490859]: invalid HE capabilities for 
> d8:07:b6:8e:97:7b
> Apr 16 07:23:39 kitchenrune iwd[1490859]: invalid HE capabilities for 
> d8:07:b6:8e:97:7b
> Apr 16 07:55:07 kitchenrune iwd[1490859]: invalid HE capabilities for 
> d8:07:b6:8e:97:7b
> Apr 16 07:55:07 kitchenrune iwd[1490859]: invalid HE capabilities for 
> ae:70:5d:05:9f:f2
> Apr 16 07:58:34 kitchenrune iwd[1490859]: invalid HE capabilities for 
> d8:07:b6:8e:97:7b
> Apr 16 08:25:08 kitchenrune iwd[1490859]: invalid HE capabilities for 
> d8:07:b6:8e:97:7b
> Apr 16 08:25:08 kitchenrune iwd[1490859]: invalid HE capabilities for 
> 1c:93:7c:73:36:92
> Apr 16 08:25:08 kitchenrune iwd[1490859]: invalid HE capabilities for 
> 06:93:7c:73:36:92

Yeah I see this on one AP around me depending on where I have my laptop. 
I think this incorrect bit setting is likely common across a lot of APs, 
maybe something within hostapd itself... Either way the warning here 
isn't something you need to worry about, although I agree its an 
"annoyance" now. The hard part is if we remove it then someone will come 
along later and say "why isn't IWD estimating the HE data rate?" and 
we'll have to waste time debugging again. At least with this its clear: 
your AP is advertising an invalid HE capabilities IE.

Thinking out loud here, one option would be to potentially flag the 
capability used and print it out with the scan results. Something like:

data_rate: 2402.0 (HE)

Then if someone complains their AP supports HE but IWD is using VHT we 
can say its _most likely_ the invalid HE capabilities. But that isn't as 
direct as the warning.

Another option would be to be less strict with the check (likely what 
wpa_supplicant does) and just take the IE as valid even though it isn't 
following the requirements of the spec... but we don't tend to do that 
unless its having some negative effect on IWD functioning correctly. For 
this, the data rate estimation is just not as high as it could be, which 
generally isn't going to change much.

Maybe if others could chime in and see if they also notice these 
warnings now.

Thanks,

James

>
> Periodic scanning info from today.
>
> I use connman to manage the networks and we have a php script to 
> scrape the network information advertised by the SSIDs. The attached 
> txt file may be interesting to see what my RPi sees.
>
> Keith
>
>
>
> On Mon, Apr 15, 2024 at 1:57 PM James Prestwood <prestwoj@gmail.com> 
> wrote:
> >
> >
> > On 4/15/24 11:50 AM, Denis Kenzior wrote:
> > > Hi James,
> > >
> > > On 4/15/24 10:15, James Prestwood wrote:
> > >> Hi Keith,
> > >>
> > >> On 4/15/24 4:24 AM, James Prestwood wrote:
> > >>> Hi Keith,
> > >>>
> > >>> On 4/12/24 10:41 AM, KeithG wrote:
> > >>>> Group,
> > >>>>
> > >>>> This is on a Pi5. this is with the 'current from git' build of iwd.
> > >>>> iwd-git/now 2.17.r0.g468cecdb-1
> > >>>> These are new errors which are showing up in the log and recur 
> a lot:
> > >>>> Apr 12 12:14:17 pi5 iwd[1537]: error parsing HT capabilities
> > >>>> Apr 12 12:14:17 pi5 iwd[1537]: error parsing non-HT rates
> > >>>> Apr 12 12:14:17 pi5 iwd[1537]: error parsing VHT capabilities
> > >>>> Apr 12 12:14:17 pi5 iwd[1537]: error parsing HT capabilities
> > >>>> Apr 12 12:14:17 pi5 iwd[1537]: error parsing non-HT rates
> > >>>
> > >>> I added these recently as well as a small modification to improve
> > >>> fallback behavior for calculating the data rate. This isn't coming
> > >>> from the driver, but the scan results. Apparently APs sending
> > >>> invalid IEs is more widespread than I thought. I'll need to change
> > >>> this to instead maybe a single warning, or maybe hidden behind an
> > >>> env var.
> > >>
> > >> I sent some patches to the list which should help. You may still get
> > >> a warning for HE capabilities though, if APs are advertising the
> > >> malformed IE.
> > >
> > > Can we find out what is causing the errors?  Is it the low RSSI?
> > >
> > > I rather we added a L_WARN_ONCE or L_WARN_THROTTLED or something
> > > instead of turning them off.
> >
> > Most likely low RSSI because I didn't handle -ENETUNREACH, so it treated
> > it as an error rather than silently dropping down to the next 
> capability.
> >
> > >
> > > Regards,
> > > -Denis
