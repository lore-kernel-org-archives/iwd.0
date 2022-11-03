Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A363163C7
	for <iwd@lists.linux.dev>; Thu,  3 Nov 2022 19:21:30 +0000 (UTC)
Received: by mail-oi1-f175.google.com with SMTP id r76so3004412oie.13
        for <iwd@lists.linux.dev>; Thu, 03 Nov 2022 12:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oHnDBBqEWOb3x38eUaIW96zhLCjrId+NFGtNxzZFYoM=;
        b=S+ljj73cj2ldYY4oBN3QFKY9RAo9EewOLftxCs4K9CVAzI9rgb6G1Y/k4mhNJXbS7i
         pDRr5poMDzqIdV2yJ34hlH3EBC/IPC/oAfj8Rz08s5+OmsJOR6rDjH76mborOLFY1v+l
         FSCmwNSyVFAT+kqirofzg9ymvVGWziS+/Izz6w+bUTFSC4Ue2euux4C0ux0g3/+BRtIH
         XiNSMmnkMNirfbfemyDoXWhA4c8SOf1akvxMUT8BFxRY4bKjmzHI8DZjgiVWzySAU51+
         mWPgQmDJbVzir4UJ1C+Fowdy4dNwZe5Xf1D29fvcTF7V2ed7IHd4PtkNKoUTD6ctpOgZ
         gVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oHnDBBqEWOb3x38eUaIW96zhLCjrId+NFGtNxzZFYoM=;
        b=hPRa/bPV2TrUTFcH5x9Tz8n19DtixHBt0shNAsCLrNbu6cf2cr34O9zK1IeuEjDyoV
         kAoMaVhQijXn3TLDQvTMvG1h6MuWv5FtAHX32dEwOHIIt6Z4doFnkuMCzs7Bpzw4Hvdr
         AfWFBiv+dm7/i4AgtI5fdqBpNpfazwDHuUka+59s8GBQRrqE38mo6PPVdJznra+tiNpt
         peEsVPCIQTQ2dLk2Dw7mV7tL7b7x9xc6gjm5mWhpN4uW1YrIwODvfXV3gA9zo9ytfO7E
         +wSHIYvUqzLKzhnS1cq/Bafl0TPb2UWvjUMW8koSfjaqLiP+IxBJ/6AfE9dlbTxCAPKQ
         N+Aw==
X-Gm-Message-State: ACrzQf0S/UbHrWCeFJCdUXfBuuWhlMTZ4iDom8azrM6wMLpSBxN1h2S5
	FCeqHO12F5MEl8Qepw6OTC8=
X-Google-Smtp-Source: AMsMyM5HtOyxNADdwFIZi1C9Vt358+23vXBUy7yPENdo2HX8VERy+rmtZLWoeFwXV4/g8F7XXY0b3Q==
X-Received: by 2002:a05:6808:2028:b0:35a:b62:7e87 with SMTP id q40-20020a056808202800b0035a0b627e87mr13126084oiw.264.1667503289706;
        Thu, 03 Nov 2022 12:21:29 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id a11-20020a05680804cb00b00339befdfad0sm710382oie.50.2022.11.03.12.21.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 12:21:29 -0700 (PDT)
Message-ID: <5aca9b77-5c66-7744-8e33-a0578b645408@gmail.com>
Date: Thu, 3 Nov 2022 14:21:28 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] doc: document global MulticastDNS option
Content-Language: en-US
To: Andrea Pappacoda <andrea@pappacoda.it>, iwd@lists.linux.dev
References: <20221103105639.8289-1-andrea@pappacoda.it>
 <20221103105639.8289-2-andrea@pappacoda.it>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221103105639.8289-2-andrea@pappacoda.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrea,

On 11/3/22 05:56, Andrea Pappacoda wrote:
> Documents the new MulticastDNS global option, also adding some more
> details regarding how and when systemd-resolved enables mDNS, and how
> iwd handles it.
> ---
> See <https://lore.kernel.org/iwd/A4TIKR.5DC9OCNE90W6@pappacoda.it/T/>
> for more context.
> 
>   doc/main.conf       |  6 ++++++
>   src/iwd.config.rst  | 19 +++++++++++++++++++
>   src/iwd.network.rst |  4 ++--
>   3 files changed, 27 insertions(+), 2 deletions(-)
> 
So overall I don't mind doing this if there's no other way, but I do wonder... 
According to [1]:

"The SetLinkLLMNR() method enables or disables LLMNR support on a specific 
network interface. It takes a network interface index as well as a string that 
may either be empty or one of "yes", "no" or "resolve". If empty, the 
systemd-wide default LLMNR setting is used. If "yes", LLMNR is used for 
resolution of single-label names and the local hostname is registered on all 
local LANs for LLMNR resolution by peers. If "no", LLMNR is turned off fully on 
this interface. If "resolve", LLMNR is only enabled for resolving names, but the 
local hostname is not registered for other peers to use.

Similarly, the SetLinkMulticastDNS() method enables or disables MulticastDNS 
support on a specific interface. It takes the same parameters as SetLinkLLMNR() 
described above."

Right now, if no setting is provided, then we do not invoke 
SetLinkMulticastDNS() at all.  If we were to send SetLinkMulticastDNS() with an 
empty string, would it just apply the global resolved defaults?  In which case, 
should we simply default to using an empty string if the setting isn't provided?

[1] https://www.freedesktop.org/software/systemd/man/org.freedesktop.resolve1.html

Regards,
-Denis
