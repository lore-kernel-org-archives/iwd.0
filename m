Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0A633CC
	for <iwd@lists.linux.dev>; Mon, 10 Oct 2022 16:55:38 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id p3-20020a17090a284300b0020a85fa3ffcso13600413pjf.2
        for <iwd@lists.linux.dev>; Mon, 10 Oct 2022 09:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=an0T+WpXb7ySxY4m9IIsqyIa8Dnjy6Nc8Me6+L0ahwU=;
        b=XDe01FyRg0vWUo1ECegi0RHvICZdhPkGO9ZItqfjRnONUZtzc0GmxAosESLH5dcu8Z
         q3xI+X+xN0ez59KY1eZbHkYsNCG1Rpys3BvbZFtCg6zbQjzkuB8y0rUyrYVQ3YtGBxD/
         CUMJ4GcCn8QXfGHd1hpbghv5nShgz/GIu1FU0v6pEGXDkUEupzNpd8NK8aFd/340pzFv
         Bwdb3R0YXvYpB8BMhQoA+6HiEiIePQxjL95f1RwoWoMtvr30yYtX29bfYAxRD3T/gKiJ
         2dpzSu4T82M3i35gXl9Bg/FjpENxftPynweXzYIxcc53UtCJ39tBpbN5l81KEb6zSkli
         D+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=an0T+WpXb7ySxY4m9IIsqyIa8Dnjy6Nc8Me6+L0ahwU=;
        b=oA4seVN6QJ4zjUCLW4q8lQjFRIKEh+zmxPLfigFE3ndFdYAiYeBmkz01+31gbkKx52
         +DuUuYEtY+S9EuePcr6xMdA/wWq/4sYKMbVfk3Z/ZL8KVIqei9y1jhxHOALHZE7J2sXn
         j9osfaLsPZCHXgdaCEJ1rM26cYz/tBhPtKmWkq93JWgmcaOqpWIUQGwsLeINw1+N7JIF
         OPkG/pZfCloou6AuBa08Qv/RspgqvRJfItGCqZEh6oE45CIMQcdzXcvwtQXpKwg+AyVG
         ITClY/iojmQpjdCiAL6jojIneOx4U2hlJmT22Q3x7z6y1hde+5qNIhoaSFipmcacrb4f
         rqnw==
X-Gm-Message-State: ACrzQf16NBi/tZHgBwM8pNMNmbp72syzmDTo2RV6jvFrOfVt8M6AGt38
	j5EmCJjukl6D7+4H3W/o0FPyHTy3vJQ=
X-Google-Smtp-Source: AMsMyM4QU7kXUL7uaelkWxCkXdDwvMHjiyCoV6xTZrIJ2eNYPFFshhqwv246+X2Ozdgc6ij+AUjg3Q==
X-Received: by 2002:a17:90b:1e03:b0:20d:7f0:7671 with SMTP id pg3-20020a17090b1e0300b0020d07f07671mr12667484pjb.174.1665420938344;
        Mon, 10 Oct 2022 09:55:38 -0700 (PDT)
Received: from [192.168.254.15] ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id 131-20020a621989000000b00561969ea721sm7356291pfz.147.2022.10.10.09.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 09:55:37 -0700 (PDT)
Message-ID: <aba92d1d10cfa49bb4683b1d727a4f147bebd5b6.camel@gmail.com>
Subject: Re: [PATCH] client: handle wide chars for table rows
From: James Prestwood <prestwoj@gmail.com>
To: Pinghao Wu <xdavidwuph@gmail.com>, iwd@lists.linux.dev
Date: Mon, 10 Oct 2022 09:55:36 -0700
In-Reply-To: <CNIDH0YNL06Q.3B8CX0X2XUXID@xps>
References: <20221008075509.26252-1-xdavidwuph@gmail.com>
	 <72fd6e3e0ee1ac040f4ad1af0dcffc5f693b3c5a.camel@gmail.com>
	 <CNIDH0YNL06Q.3B8CX0X2XUXID@xps>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2022-10-11 at 00:09 +0800, Pinghao Wu wrote:
> The current non-codepoint UTF-8 method assumes that a codepoint
> occupies
> one column while printing. This is not true for some characters like
> Chinese characters, which occupies two columns.

Ah ok, in this case it may be best to combine you're changes with the
non-codepoint check since you're changes are more complete for handling
utf-8. I'll review the original patch.

> 
> The motivation of this patch is to handle these "wide" (in printing
> columns) chars properly via wcwidth(). It's not actually about
> non-UTF-8, but it is also useful for that case.


