Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF91125D5
	for <iwd@lists.linux.dev>; Mon, 28 Aug 2023 18:39:43 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6bd3317144fso2893668a34.1
        for <iwd@lists.linux.dev>; Mon, 28 Aug 2023 11:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693247982; x=1693852782;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IQ/BBjt8AdtjjXokAIGlmLBlremj4af4DZLknNYno1U=;
        b=qgHLGAqWLfS76+nOAd/TkwrYtlHzyaNzSt1CsgDoBOyyETex6zNNAMzgq2v6UNxc6X
         cVkeLUPWpSrk55SJCh2zgsSYLMVpwhqcq1w2e2HKhfjj9HNoDL1e9swL1Hwks6xIVkRw
         Oz33vCMU7Lv1O0eDsehFmKqbcIC/OwyVwkjxMGUtGIql5jNKh7nYOE0geRz97YeJKW7o
         Fh40EcLGbOL+9A5ePjuO2TZs/bNITKTWTNcWKRmCPuJFtdDnQds8SQwUDq8iwmxwZQx8
         O1yr4hF1lgHGSsrkwV5IPuGXOtrItNak6KWzHlzV0CZuvLDk7+kD2jx20zopRVGwmSt8
         enmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693247982; x=1693852782;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IQ/BBjt8AdtjjXokAIGlmLBlremj4af4DZLknNYno1U=;
        b=QaiY8UN8Ztj+nL45ZPjIT16AUw1yy20HZRl9hrkF/qH3KbAiidtPJrlLZSdPcqlO9D
         f3QF1BHUQQ+pUSAniDlycwGglZtjcztXjS0PPY9wSpAmQuE1nC0Z0RX/MC4F+/P+zSSs
         ZcK0l4ijtuG2+im7wq50TuFg2ZN9CQOhFO/Ow/LbWE0m9qCLH85Itt92CJiJQUwfWVQ5
         +ZkFNcGZBwjQNKN187Esk3CvUyQZ0Qavaeh0WfUgGKYgd4MmOU4HF4JjF3D73lWZSwzn
         Q9PtJGv5qMr1Wzl0HMNMbWv7aKNItpq+sGaveIvjBoC53vAlSJS5ZjH2WpyuQs7daRkk
         gBkQ==
X-Gm-Message-State: AOJu0YyznMXPNXSzuWZV3GynSfoP7TgFEC6Djk3hzbC5rWk1k5cj6zb6
	evOPYjpJaZLxCUe1o5Hh6RQ=
X-Google-Smtp-Source: AGHT+IEL8xB+EsyLJE6Hspms7+ZADjN+dORv3ycT3+YZujR76q1qoF9lg0b9aJZN75Ud+DiYSBhGSw==
X-Received: by 2002:a9d:6314:0:b0:6bd:be5:daa2 with SMTP id q20-20020a9d6314000000b006bd0be5daa2mr12896016otk.33.1693247982273;
        Mon, 28 Aug 2023 11:39:42 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id d21-20020a9d4f15000000b006b9ad7d0046sm3715212otl.57.2023.08.28.11.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 11:39:41 -0700 (PDT)
Message-ID: <111f8eb8-28d5-50d9-3926-51e29ba9ead4@gmail.com>
Date: Mon, 28 Aug 2023 13:39:40 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] station: fall back to reassociation under certain FT
 failures
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230822152931.276136-1-prestwoj@gmail.com>
 <20230822152931.276136-3-prestwoj@gmail.com>
 <4ed15cee-23cc-ded0-ef37-5e1f4424ddc6@gmail.com>
 <a6522b7e-0cec-4f15-9bf3-8e53d832f0d4@gmail.com>
 <f01aeb4a-b909-5fe8-3bde-5b77639bcba6@gmail.com>
 <4b2351d6-9508-4c55-9929-05591aeec777@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <4b2351d6-9508-4c55-9929-05591aeec777@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

>> Another possibility would be to insert the BSS twice (or reinsert once FT 
>> fails), once with FT and once without FT and try them in rank order. Still, 
>> there's almost no penalty to trying all FT candidates, so unless the ranking 
>> calculation is really off, I think that is a better approach.
> 
> Ok, I'd rather go this route then, re-insert the BSS without FT after this 
> specific failure.

Ok, lets do that then.

> 
> Would you want me to put this behind a config option? Or you think reassociation 
> based on ranking is ok? Again, it would only be with status=53 so I think the 
> impact is minimal.
> 

Make it the default behavior.

Regards,
-Denis
