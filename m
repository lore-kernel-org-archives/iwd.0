Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD8220E4
	for <iwd@lists.linux.dev>; Fri, 12 Aug 2022 16:03:10 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-116c7286aaaso1378957fac.11
        for <iwd@lists.linux.dev>; Fri, 12 Aug 2022 09:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=H9boJwox2w3HFIfeK0SiZ8uFvcvyWqwjsJi3u3ckHLw=;
        b=VLhYzyYhR0jOOlS07GbJP6SNS1yVq4bQrug6TRvyg03XBbsEj7KZODH/THBA+tmLG3
         nesAlM/K49pUUJ+EU6+LyObSjYiR1XCGEumeFZtA5w3KTj9LSBRcTP8z3knWv2Zce4yF
         fL/clf4blmNplJ/2q8dsbd+RiWzBrB1E9/RHPJKg37A5ARsKdeP1uDqTQEk8cR+ZF1Lg
         YqxxGB8L7XfG9tmFWVAaeLfdPBOtnqSb9Z+i6VecGxDdlkmJXsm6AkPPQB+CZ+0QN5XF
         XyfdY67uOUDG2paalsW258tAPI/B7jX6v21ZueY5/lwPUHpXFyKK2oi610DDN/0fiw9v
         phfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=H9boJwox2w3HFIfeK0SiZ8uFvcvyWqwjsJi3u3ckHLw=;
        b=KGCH+2l7yPHTvTYLkIUPcAdPE7BcfXPXz/IO23444BY4umhYazMBZCHB6Jn+K/4rmD
         OnWawnYzW24XFlylQnswk/jvJAnxCqR+pow3Wos7GZ7HXdcRU2SRf2Btw7zrD1iuHCMn
         r+aZY9eo12LPLwKC6r9cQ4TZyNiTwNQkHV3BsqiwA6FTRjpK1Iarb52wQ/hWJnMoUyh5
         jhUvhNTN86bpYKTPSHHHEhIiBFZfHS/gPzuokHTH8Ms+6KDMhVYvLf4FhFT1Y33Htm8t
         EazdB6TTjai+htpUcFj2k0iUw0Wj7kaUNOHhdI6TUfBYO8HVW4cIQQw0oojhVRkXE+zQ
         rJ+w==
X-Gm-Message-State: ACgBeo2y03wUGDvg2G2eE5wGUDCQb8hvrgUs99bwor/uPsdNEtHdCKHJ
	sFW4ZAg83/czGiBYu4Oq6rGfgfuxS94=
X-Google-Smtp-Source: AA6agR5edG3ZaoD99+B5L8vaF3WW1L2YRtHXksNA6fYj6/V90Tte8p/3sglGSRXRF5VzoDhiGy5GPQ==
X-Received: by 2002:a05:6870:b154:b0:110:b77f:4d73 with SMTP id a20-20020a056870b15400b00110b77f4d73mr6089572oal.199.1660320189932;
        Fri, 12 Aug 2022 09:03:09 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id w25-20020a4a3559000000b004358b15cfe8sm396127oog.13.2022.08.12.09.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 09:03:09 -0700 (PDT)
Message-ID: <ebbf6098-299a-63cf-e016-5d200784970a@gmail.com>
Date: Fri, 12 Aug 2022 10:45:34 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: iwd needs restart after suspending
Content-Language: en-US
To: Joachim Breitner <mail@joachim-breitner.de>, iwd@lists.linux.dev
References: <f79517c3f23c14dcd6db0dd5f3fb48fdeb687315.camel@joachim-breitner.de>
 <fa74ccdf82f2f4db651d50e51583bd85eca3fb28.camel@joachim-breitner.de>
 <47479f89-c065-8402-818b-d0becc285c27@gmail.com>
 <bb8de096a7a6d3775271e598189c312e1d9079ac.camel@joachim-breitner.de>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <bb8de096a7a6d3775271e598189c312e1d9079ac.camel@joachim-breitner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Joachim,

>    Model: "Intel Wi-Fi 6 AX201"

Ok, we should have one of these to test on our side.  But so far I see nothing 
to indicate that this is an iwd bug.  Seems like a kernel regression?  I would 
file a bug against the kernel or check if something like this already exists. 
See bugzilla.kernel.org.

>>
>> So the question is why is the kernel changing this behavior?
> 
> I could narrow it down to 5.15 vs. 5.17, if that helps. But
> linux/drivers/net/wireless/intel/iwlwifi seems to be a rather busy
> directory:
> https://github.com/torvalds/linux/commits/v5.17/drivers/net/wireless/intel/iwlwifi

That would help, but ideally we need a bisected commit or something else 
concrete to work with.  Do you see anything suspicious in dmesg?

Regards,
-Denis
