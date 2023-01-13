Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE242BA57
	for <iwd@lists.linux.dev>; Fri, 13 Jan 2023 23:17:17 +0000 (UTC)
Received: by mail-oo1-f50.google.com with SMTP id r1-20020a4a3701000000b004f2b4f8200eso55962oor.7
        for <iwd@lists.linux.dev>; Fri, 13 Jan 2023 15:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gEQnYsihxhKfhq26rMRqEEd5+8TYh2cU/GGiq+Q8nQQ=;
        b=Q+0nskCZ/Xm37SHnvDInadK1KmPoEdpcE+4WwByqN5zw9M2njVEH09gIOswoWhdwJ2
         vnDOd2rltbYWcnt+VhQtNPGoEfUFnodzUwQC1mzwJLK+KL+m6U5MqJuABV2JqaluXA94
         H+E+vBMFiH0lrAOjpXT9+I3glOUcNH6chyFfZcBWKyNdN91G+raT+lHfSK2Empipsefs
         U71or1dRoz7rslRFnNKEEigqNi+zpuuzaSTOaShkNVuX/975i/RyCXw2WurafbvAPFqI
         9+/Dklwj9STch5s7X7OT+nT4PnW+7II7j4OzH+vLHhlOcbAlwzXpsmTh4lwmtJAGZwbT
         eIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gEQnYsihxhKfhq26rMRqEEd5+8TYh2cU/GGiq+Q8nQQ=;
        b=FeVpuqZuihYWmyPW3cIHoRq4cLXeNW2aXcZ+RNgKrs3bhJTbPRdzDqQcJ/8o3BZxUw
         t8NLkJlvaD4i/Ddhz+aeoZT4QgPlTlh8M9UTUE8PkGIuZYc3G76p/qK3QzTb3HjVUTKB
         oXEWoebMnU1aGaH8UvvMfBjrEbWHbwhoHL9IF7GFNRPNEvcEToV1xDtBYoG3UtxSin4z
         hu7N3Wfc8AAAEyoipYItFvABpO9e0s7UkCqrKrT+4UL4D+KR1tdOa4/xa+teVejJgniP
         qKp7SkABv8DubHJ+Fo40+ElvOApiwXwutcTJ9lINA1y/6eAYoVnDMaktJeWmhEtUsnbw
         mfng==
X-Gm-Message-State: AFqh2kqa56U5ZuoUDLoGwKLhP5UBar7mTl8TJaQ4z1NWAM1zrDrBlgSf
	jZkxspq1HPW1geliEQHJR+3lbD2glQ8=
X-Google-Smtp-Source: AMrXdXupkEQMACYBSAWIQbJSXueLZHqMzXeru/PHbOB9GGKrjC4mYaY1j4Z3S9aidMwRF/GGaLbTCA==
X-Received: by 2002:a4a:4b07:0:b0:4a0:23af:db58 with SMTP id q7-20020a4a4b07000000b004a023afdb58mr34794654ooa.7.1673651836746;
        Fri, 13 Jan 2023 15:17:16 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bc31-20020a056820169f00b0049f8b4b2095sm10356797oob.44.2023.01.13.15.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 15:17:15 -0800 (PST)
Message-ID: <d748e42c-c2af-13e0-45db-6266862edbbc@gmail.com>
Date: Fri, 13 Jan 2023 17:01:21 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/3] station: add checks to prevent multiple roam scans
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230113212436.794519-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230113212436.794519-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 1/13/23 15:24, James Prestwood wrote:
> Under the following conditions IWD can accidentally trigger a second
> roam scan while one is already in progress:
> 
>   - A low RSSI condition is met. This starts the roam rearm timer.
>   - A packet loss condition is met, which triggers a roam scan.
>   - The roam rearm timer fires and starts another roam scan while
>     also overwriting the first roam scan ID.
>   - Then, if IWD gets disconnected the overwritten roam scan gets
>     canceled, and the roam state is cleared which NULL's
>     station->connected_network.
>   - The initial roam scan results then come in with the assumption
>     that IWD is still connected which results in a crash trying to
>     reference station->connected_network.
> 
> This can be fixed by adding a station_cannot_roam check in the rearm
> timer. If IWD is already doing a roam scan station->preparing_roam
> should be set which will cause it to return true and stop any further
> action.
> 

All applied, thanks.

Regards,
-Denis

