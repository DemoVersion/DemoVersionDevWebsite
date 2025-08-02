---
layout: default
title: "Let’s Chat"
permalink: /contact/
---
<script>
function redirectToGoogleForm() {
  const base = 'https://docs.google.com/forms/d/e/1FAIpQLScqSdEztc4jrlQcmlPfVxrr-NFNJzvAsezdyAa3SBYHGlTLIQ/viewform';
  const name      = document.getElementById('name').value;
  const interest  = document.getElementById('interest').value;
  const project   = document.getElementById('project').value;
  const timeline  = document.getElementById('timeline').value || 'No preference';

  const fullDesc = `Rough timeline: ${timeline}\n\n${project}`;

  const p = new URLSearchParams({
    'entry.1244177973': name,
    'entry.1470443616': interest,
    'entry.1040121080': fullDesc
  });

  window.location.href = `${base}?${p.toString()}`;
}
</script>
<div class="flex-grow flex items-center justify-center">
<section class="mx-auto max-w-lg min-w-[20rem] px-6 py-20 bg-white dark:bg-slate-900 rounded-lg shadow-md">
  <h1 class="text-4xl md:text-xl lg:text-3xl font-normal tracking-wide mb-6 uppercase text-center text-gray-800 dark:text-gray-100">LET'S CHAT</h1>
  <form class="space-y-5">
    <div>
      <label for="name" class="block text-sm font-medium text-gray-700 dark:text-gray-300">
        Name <span class="text-red-500">*</span>
      </label>
      <input
        type="text"
        id="name"
        name="name"
        required
        class="mt-1 block w-full rounded-md border border-gray-300 dark:border-slate-700 bg-white dark:bg-slate-800 px-3 py-2 text-gray-900 dark:text-gray-100 focus:outline-none focus:ring-2 focus:ring-indigo-500"
      />
    </div>
    <div>
      <label for="interest" class="block text-sm font-medium text-gray-700 dark:text-gray-300">
        What are you looking for? <span class="text-red-500">*</span>
      </label>
      <select
        id="interest"
        name="interest"
        required
        class="mt-1 block w-full rounded-md border border-gray-300 dark:border-slate-700 bg-white dark:bg-slate-800 px-3 py-2 text-gray-900 dark:text-gray-100 focus:outline-none focus:ring-2 focus:ring-indigo-500"
      >
        <option value="">Select one…</option>
        <option>ML Experiment Design and Development</option>
        <option>Mentoring</option>
        <option>Collaboration or partnership</option>
        <option>Something else</option>
      </select>
    </div>
    <div>
      <label for="project" class="block text-sm font-medium text-gray-700 dark:text-gray-300">
        Tell me a bit about your project <span class="text-red-500">*</span>
      </label>
      <textarea
        id="project"
        name="project"
        rows="4"
        required
        class="mt-1 block w-full rounded-md border border-gray-300 dark:border-slate-700 bg-white dark:bg-slate-800 px-3 py-2 text-gray-900 dark:text-gray-100 focus:outline-none focus:ring-2 focus:ring-indigo-500"
      ></textarea>
    </div>
    <div>
      <label for="timeline" class="block text-sm font-medium text-gray-700 dark:text-gray-300">
        Rough timeline
      </label>
      <select
        id="timeline"
        name="timeline"
        class="mt-1 block w-full rounded-md border border-gray-300 dark:border-slate-700 bg-white dark:bg-slate-800 px-3 py-2 text-gray-900 dark:text-gray-100 focus:outline-none focus:ring-2 focus:ring-indigo-500"
      >
        <option value="">No preference</option>
        <option>ASAP</option>
        <option>1–3 months</option>
        <option>Flexible</option>
      </select>
    </div>
    <div class="text-center">
      <button
        type="button"
        onclick="redirectToGoogleForm()"
        class="px-5 py-2 bg-indigo-600 hover:bg-indigo-700 text-white font-medium rounded-md shadow-sm transition"
      >
        Send Message
      </button>
    </div>
  </form>
</section>
</div>