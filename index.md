---
layout: default
title: Personal Website
---


<section class="flex flex-col justify-center items-center px-4 py-12 bg-white dark:bg-slate-900">
<h1 class="text-4xl md:text-5xl lg:text-6xl font-normal tracking-wide mb-6 uppercase">Hello, world</h1>
<div class="max-w-2xl text-base md:text-lg tracking-tight leading-relaxed text-gray-600 dark:text-gray-400 normal-case">
    <img
      src="/assets/avatar.svg"
      alt="Hesam Haddad"
      class="float-left w-20 h-20 rounded-full mr-4 mb-2
             transition-transform transform hover:scale-105 hover:shadow-lg"
    />
    <p>
      I'm Hesam Haddad, Machine Learning Engineer with a Master’s in NLP, building end-to-end AI pipelines and driving cloud ML deployments, mentoring peers, blogging.
    </p>
  </div>
</section>

<section class="container mx-auto max-w-7xl px-4 lg:px-8 py-8">
  <div class="grid grid-cols-1 lg:grid-cols-4 gap-6">
    <div>
      <div class="flex items-center mb-4">
        <div class="w-2 h-3 bg-slate-800 dark:bg-slate-300 mr-2"></div>
        <h2 class="text-xl md:text-2xl">RECENT WORK</h2>
      </div>
    </div>
    <div class="lg:col-span-3 grid grid-cols-1 md:grid-cols-3 gap-6">
      {%- assign posts_list = site.posts | sort: 'date' | reverse -%}
      {%- assign total_posts = posts_list | size -%}
      {%- for post in posts_list -%}
        {%- assign idx = forloop.index -%}
        <article class="post-card grid grid-rows-[auto_auto_1fr_auto] gap-2 h-full{% if idx > 3 %} hidden{% endif %}">
          <time class="block text-xs text-slate-500 dark:text-slate-400">{{ post.date | date: '%Y-%m-%d' }}</time>
          <h3 class="text-lg md:text-xl font-semibold">{{ post.title | truncatewords: 10, '...' }}</h3>
          <p class="text-sm normal-case leading-relaxed">{{ post.description | truncatewords: 20, '...' }}</p>
          <a href="{{ post.external_url }}" class="inline-block text-indigo-500 hover:text-indigo-600 dark:text-indigo-400 dark:hover:text-indigo-300 transition-colors hover:underline">GO TO WEBSITE →</a>
        </article>
      {%- endfor -%}
    </div>
  </div>
  {%- if total_posts > 3 -%}
  <div class="mt-4 text-center">
    <button id="show-more" class="text-indigo-500 hover:text-indigo-600 dark:text-indigo-400 dark:hover:text-indigo-300 transition-colors hover:underline">SHOW MORE ↓</button>
  </div>
  {%- endif -%}
</section>