Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA2B3EA7E
	for <iwd@lists.linux.dev>; Fri, 17 Nov 2023 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7lsAqRU"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6ce2cf67be2so1081630a34.2
        for <iwd@lists.linux.dev>; Fri, 17 Nov 2023 07:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700236189; x=1700840989; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JTjk8Pn53K4ev7Hb9aUD3cN5DOBNlZBDuH/ze5wSq9I=;
        b=a7lsAqRU6vdK9Ui0+jSBigjQ7cm879cN/fkC7Elju3WBPRsWtKKWVV/kpkqfizTwvP
         bqSemvNP3r2ZSerwnk3gzFBv7z0OGD+tJ67fnvfEWQ6a82GJyG2AquM2XGfIPiBJY2Vc
         yV9fuBHY7xgLUn0xtLxxEWoUZzB5601xW4NRcA+wtnhF8/Ogj9q05IkyAb59whyZkz1C
         KVXFPUIiyT4XppHMR/5uBXdt55vSUmg+A7TEC38JykgJe+58febuiO2LziMc/ZV3DHan
         6/JrLW0eudrF6s3/mIwD4pfTvOtmPCPa1eewT7S5N9AZPCF+tXMo/Gq99a4xjw1IEY5a
         BGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700236189; x=1700840989;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JTjk8Pn53K4ev7Hb9aUD3cN5DOBNlZBDuH/ze5wSq9I=;
        b=ayDRdUO1oyIaYIRS9GPGJZ/XRJvAR8vst/WyVDWg9rIG8fMTMDfuDyDkQVTVY/LIWs
         4RDuFdr8xsis8WOZhUWrqaIB1c4ElYdLzvg6+K4FxXey7yQ/YOlXzHnwFYdi/y3tNr+/
         CfjCxLdsLH/PbgFoSKfW73nAQF1UEDvFnF6b1H+C6C74OpEosR8luLUgYev9U23nP3Wk
         s/6n7u+n3U8jr8FO0ZKc0I+WMwns/kKHFrYBzuDKel07ULViYQEuv+vOXqxaASPm0REo
         E0Qz86vJtOm9eRXBG3srWtOh6c10Rs00QQllPYgLSj7ITIQgfjlGBF7aR2fLWdisy8Gr
         oETg==
X-Gm-Message-State: AOJu0YyQQkTzstrP/4GRx2TP4ise0AXchWJTCNX5Q30Omdg9XawImRiW
	emlQ7xAZbb4u1ud3b0/M+GM=
X-Google-Smtp-Source: AGHT+IEZNXIRReFayE5DFcNrKCsOg7pnX6Br9+Y6VRNa66At/+FjOFmS3cMHfiLdkfuc5cqj5rqiUQ==
X-Received: by 2002:a05:6830:7192:b0:6ce:2733:f71b with SMTP id el18-20020a056830719200b006ce2733f71bmr15003520otb.26.1700236188789;
        Fri, 17 Nov 2023 07:49:48 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id d14-20020a9d51ce000000b006b9443ce478sm274653oth.27.2023.11.17.07.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 07:49:48 -0800 (PST)
Message-ID: <7e815913-7537-4822-8106-1869db13e9bc@gmail.com>
Date: Fri, 17 Nov 2023 09:49:45 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dpp-util: add support for 3rd party JSON fields
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231117141227.60722-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231117141227.60722-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 11/17/23 08:12, James Prestwood wrote:
> The DPP spec allows 3rd party fields in the DPP configuration
> object (section 4.5.2). IWD can take advantage of this (when
> configuring another IWD supplicant) to communicate additional
> profile options that may be required for the network.
> 
> The new configuration member will be called "/net/connman/iwd"
> and will be an object containing settings specific to IWD.
> More settings could be added here if needed but for now only
> the following are defined:
> 
> {
>    send_hostname: true/false,
>    hidden: true/false
> }
> 
> These correspond to the following network profile settings:
> 
> [IPv4].SendHostname
> [Settings].Hidden
> ---
>   src/dpp-util.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++---
>   src/dpp-util.h |  4 +++
>   2 files changed, 70 insertions(+), 3 deletions(-)
> 

All applied, thanks.

Regards,
-Denis

