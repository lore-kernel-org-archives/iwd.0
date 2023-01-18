Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE233205
	for <iwd@lists.linux.dev>; Wed, 18 Jan 2023 15:12:31 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-15f97c478a8so340776fac.13
        for <iwd@lists.linux.dev>; Wed, 18 Jan 2023 07:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AVbJicZalCoIT250gYlc3EFwlsM2yVKmLdU6rJKsUVI=;
        b=j7sB6Xu7jLaHY3aieaOEVrDRA0OuW/6irykvRTuM7hg9zJNmr73DHCYiTWeXbOmktB
         Nv+jxGywIhQhUbJqRmxh4KYL0rar+tHqqKbDlUWk8/4dFMDAuRom5bHmMJOm2lvw7rBY
         Shuu9coPIcgwQm4fANsBuYK1Nu46M3VnjWdGgqeNNN6E85bN6iMsb3W9JyHLDneopipR
         j+xg+YyFIg20h3O+9isiinYJLOod/pSAov5mRUrcAlUfwmpvLzHQ8IM8OpPvGLLqLnQI
         3F5i6mI5ikiOj+oqKLqWLGoNWez+PVuXyg3Eyl4LS77Tpb4g0hRretc7XfylHI1ZHq+7
         5ZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVbJicZalCoIT250gYlc3EFwlsM2yVKmLdU6rJKsUVI=;
        b=pcCHBq8Q9LXmuDfThHYHfb2fpZzXa3/1sp84PKM+hCI7yCWSqjNKUopKQc4kmlsaVq
         3N8q+XF+E/39uYX44+syAsylFA8Ws/s7vVeV+PBzeLuifExa4j3IZXqR3wWqp634NPyL
         DOFSFyBMpkBj+s2Dn/FapK1k/4XKTrXq+r4RssyQt+9dXMKFoayedZTfTz8tkYQodEm+
         rgff4xNreBmW20GNlRUPY/w4yvqhpi44p/mBEEHvr5UsCZpDJR88Q1AcBigwk8/K5vBV
         p093wPPzHWWI1dSslB5v+ClUo+qXh+yPEwyQmlKUrH8wt94n58M/N/wnLUoVupSyqmMl
         +4DQ==
X-Gm-Message-State: AFqh2kplwRePnhNrf9Z7uA58mNqSGgiYUz0kT/sZTRcEmt0oqAhJAMRv
	nYAvz4L1YJpmzlLavBsr6E0=
X-Google-Smtp-Source: AMrXdXsf45urZ6mWbdp5oSjXXASaJsW7d2z+AaRbkZqGoj6dssdsPbgIeSfmNYhIHZMHCejJPlt9fg==
X-Received: by 2002:a05:6871:4045:b0:15b:a84e:a6b3 with SMTP id ky5-20020a056871404500b0015ba84ea6b3mr4098946oab.5.1674054750345;
        Wed, 18 Jan 2023 07:12:30 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id eq2-20020a056870a90200b0014fb4bdc746sm18320242oab.8.2023.01.18.07.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 07:12:29 -0800 (PST)
Message-ID: <6ebeca95-8618-f398-6a4e-e1edf8d65883@gmail.com>
Date: Wed, 18 Jan 2023 09:06:32 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: ECDSA support
Content-Language: en-US
To: Michael Yartys <michael.yartys@protonmail.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <-H_hDnis_8eufaXJO7ObNd3y7Tys74ouHJg_A9OVHKpLIOMHWKBaayXV0QC0Ss61b5kZdOPQP5tIU0ySQF1XWgYc8zlQQ9qizmcGNw7JYf8=@protonmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <-H_hDnis_8eufaXJO7ObNd3y7Tys74ouHJg_A9OVHKpLIOMHWKBaayXV0QC0Ss61b5kZdOPQP5tIU0ySQF1XWgYc8zlQQ9qizmcGNw7JYf8=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

On 1/18/23 07:16, Michael Yartys wrote:
> Hi
> 
> I've been unable to connect to my university Eduroam network ever since they switched their certificates from RSA to ECDSA. As far as I know, iwd has been working on getting ECDSA support into the kernel for a while now. What's the latest news on this? I would really prefer to ditch wpa_supplicant due to the superior roaming functionality of iwd, which is really useful on my FT-SAE home network.

ECDSA support is already in iwd, but it requires the following fix to the kernel 
which hasn't been upstreamed yet:

https://patchwork.kernel.org/project/keyrings/patch/20220826145119.9375-1-denkenz@gmail.com/

We've resent this twice now and there's crickets on the mailing list.  If others 
want to nudge the upstream maintainers, be our guest :)

Regards,
-Denis
