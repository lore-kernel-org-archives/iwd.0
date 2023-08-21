Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEE8524C
	for <iwd@lists.linux.dev>; Mon, 21 Aug 2023 12:13:36 +0000 (UTC)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-58d31f142eeso36042517b3.0
        for <iwd@lists.linux.dev>; Mon, 21 Aug 2023 05:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692620016; x=1693224816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V5NGIcEkIyJffoDM4hnfA88HaQp4qP1uYXVfeOw7+ek=;
        b=cVHzSxCKS9v7hqlT4gVEILNQinqxs5WaLhVN4IvmQm6kLvbHAjwD9HP21P7R4Z9wpB
         iIROIZF9xHW7kC7z9sMFbE7TDFv4c/n9xHndRMQlEOyU8dM8h+d1UwrNJbS3iM1Jm6S/
         cveyf3wTL7Bsow4g2UItGKKC5w08hWQj9jkYXBYNYVqVfT743rhUiOq068qkxKyYDoHZ
         g6L6KYJJS7Uqk3I3zM2pnwAQUW+T2D80Xw19VaXWo/BOrbzk/6lfs1IeVkQ+BoOmvDqS
         XX/IQQMDK/MJn3WEqEjNSogJynrnrXbI3r4bYF8pQdPdcYZdD8H408WR1kz5Zp4MZmLn
         LZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692620016; x=1693224816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V5NGIcEkIyJffoDM4hnfA88HaQp4qP1uYXVfeOw7+ek=;
        b=MepL/eeOsyd3ASxbX7wYj8/BpyWORVq7Opn5tm6sHzNup1h2ZOh5LSMZR4x9RRhwn/
         lPvRhATNB7+yYnZNcXFydYkY4+rZHW9F17p9VBa1vm3j0ErmIRweXw6AKFY11ZirHZjr
         26wTqsAJwba4yST8HyJLSC+5rZ0vKuLdQr41bVmOeWbXyu/xyX4zn6wEcDy5fQevFs2b
         LLAtzm0jelk2OQMC3PHv1p5zc3rpEHQ+G52BTc9sfZUBZ0bp3pUVlYeLWPvNoCb8R0sb
         waayjOSuZyoNd63080o6eIslNF/Vb/7NBEJVk/bsXhaSj7NoSznz9E6qjoNF5kXHLarj
         YPcQ==
X-Gm-Message-State: AOJu0YwKXXSlDK6lSZxVyhbZOOm83rmbETc2gSMDb7+mVS4/zfVo8ndB
	fW353hV3NAqYlMChUMsdTnnJd7Iq98E=
X-Google-Smtp-Source: AGHT+IHJ+9tchK0nmlEB2MyQvk+Xa7YnSNsZCzu+BQ1aItpbg3PQYhADdtkGk/U9D6k/zjMEM5RTLw==
X-Received: by 2002:a0d:c947:0:b0:589:fcb2:d57f with SMTP id l68-20020a0dc947000000b00589fcb2d57fmr7988791ywd.37.1692620015995;
        Mon, 21 Aug 2023 05:13:35 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id x137-20020a0dd58f000000b005837b48d16csm2180934ywd.84.2023.08.21.05.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 05:13:35 -0700 (PDT)
Message-ID: <fa11a71a-42ff-4c54-9f0d-e8635e0782b5@gmail.com>
Date: Mon, 21 Aug 2023 05:13:33 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Segmentation fault
To: Michael John <MJohn@midmark.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <CYXPR08MB92949D45E846096B18128C3EAE1EA@CYXPR08MB9294.namprd08.prod.outlook.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CYXPR08MB92949D45E846096B18128C3EAE1EA@CYXPR08MB9294.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

If this is a debug-enabled dump could you just post the stack trace? 
That way it won't require people log in to MS to see it. If not, how big 
is the file? We may want to figure out another way to share it.

Thanks,
James

On 8/21/23 5:09 AM, Michael John wrote:
> Hello,
> 
> I hit a segmentation fault with iwd version 2.7, and captured a coredump. I've attached it at my onedrive below, please let me know if you need more information.
> 
> https://midmark-my.sharepoint.com/:u:/r/personal/mjohn_midmark_com/Documents/core.iwd.0.a68e5068b8214b27904b0fc85601ac35.241.1692277585000000?csf=1&web=1&e=4NPwg3
> 
> Thanks,
> -Michael John
> CONFIDENTIALITY NOTICE: This message, including any attachments, contains confidential information intended for a specific individual and purpose. If you are not the intended recipient, you should delete this message and any disclosure, copying, or distribution of this message, or the taking of any action based on it, by you is strictly prohibited.
> 
